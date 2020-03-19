//
//  BaseNetWorkingRequest.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/15.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "BaseNetWorkingRequest.h"
#import "AFNReqeustError.h"
#import "BaseNetRequestConfig.h"

@implementation BaseNetWorkingRequest

#pragma mark - 上传图片
+ (NSURLSessionDataTask *)AFNReqeustType:(AFNRequestType)requestType reqesutUrl:(NSString *)url params:(NSDictionary *)params img:(NSData *)uploadImg success:(SuccessCallBack)success failure:(FailureCallBack)failure {
    [BaseNetRequestConfig netRequestConfig].uploadImg = uploadImg;
    return [self AFNReqeustType:requestType reqesutUrl:url params:params success:success failure:failure];
}

#pragma mark - 请求数据
+ (NSURLSessionDataTask *)AFNReqeustType:(AFNRequestType)requestType reqesutUrl:(NSString *)url params:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)failure{
    [[BaseNetRequestConfig netRequestConfig] setRequestHeader:params];
    switch (requestType) {
            case AFNRequestType_Get:
            return [self AFNGetRequestUrl:url params:params success:success failure:failure];
            case AFNRequestType_Post:
            return [self AFNPostRequestUrl:url params:params success:success failure:failure];
            case AFNRequestType_Upload:
            return [self AFNPostRequestUploadImg:url params:params success:success failure:failure];
        default:
            break;
    }
    return nil;
}

#pragma mark - 取消网络请求
+ (void)cancelRequestWithRequestTask:(NSURLSessionDataTask *)requestTask{
    for (NSURLSessionDataTask *task in [BaseNetRequestConfig netRequestConfig].dispatchTable) {
        if (task.taskIdentifier == requestTask.taskIdentifier) {
            [requestTask cancel];
            NSLog(@"取消网路请求 :%@ 地址 :%@",requestTask,requestTask.currentRequest.URL.absoluteString);
            [self removeRequestTask:requestTask];
            break;
        } else {
            NSLog(@"请求缓存中标示 %ld 取消请求标示:%ld",task.taskIdentifier,requestTask.taskIdentifier);
        }
    }
}

+ (void)cancelRequestWithRequestTaskList:(NSArray<NSURLSessionDataTask *> *)requestTaskList{
    WeakSelf;
    [requestTaskList enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf cancelRequestWithRequestTask:obj];
    }];
}

#pragma mark - get请求
+ (NSURLSessionDataTask *)AFNGetRequestUrl:(NSString*)url params:(NSDictionary*)params success:(SuccessCallBack)success failure:(FailureCallBack)failure {
    WeakSelf;
    NSURLSessionDataTask *task = [[BaseNetRequestConfig netRequestConfig].manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf removeRequestTask:task];
        NSDictionary *dict = @{};
        if ([responseObject isKindOfClass:[NSData class]]) {
            dict = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:kNilOptions error:nil];
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = (NSDictionary *)responseObject;
        }
        if (success) {
            success(task,dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf removeRequestTask:task];
        if (task.state != NSURLSessionTaskStateCanceling) {
            if (failure) {
                failure(task,[[AFNReqeustError alloc] netReqeustError:error url:url requestId:[NSNumber numberWithUnsignedInteger:task.taskIdentifier]]);
            }
        }
    }];
    return [self storeRequestTask:task];
}

#pragma mark - post请求
+ (NSURLSessionDataTask *)AFNPostRequestUrl:(NSString*)url params:(NSDictionary*)params success:(SuccessCallBack)success failure:(FailureCallBack)failure {
    WeakSelf;
    NSURLSessionDataTask *task = [[BaseNetRequestConfig netRequestConfig].manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf removeRequestTask:task];
        NSDictionary *dict = @{};
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSError *jsonError = nil;
            dict = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:kNilOptions error:&jsonError];
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = (NSDictionary *)responseObject;
        }
        if (success) {
            success(task,dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf removeRequestTask:task];
        NSLog(@"数据请求错误 %@",error);
        if (task.state != NSURLSessionTaskStateCanceling) {
            if (failure) {
                failure(task,[[AFNReqeustError alloc] netReqeustError:error url:url requestId:[NSNumber numberWithUnsignedInteger:task.taskIdentifier]]);
            }
        }
    }];
    return [self storeRequestTask:task];
}

#pragma mark - 上传图片
+ (NSURLSessionDataTask *)AFNPostRequestUploadImg:(NSString*)url params:(NSDictionary*)params success:(SuccessCallBack)success failure:(FailureCallBack)failure {
    WeakSelf;
    NSURLSessionDataTask *task = [[BaseNetRequestConfig netRequestConfig].manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData:[BaseNetRequestConfig netRequestConfig].uploadImg name:@"img" fileName:fileName mimeType:@"multipart/form-data"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf removeRequestTask:task];
        NSDictionary *dict = @{};
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSError *jsonError = nil;
            dict = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:kNilOptions error:&jsonError];
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = (NSDictionary *)responseObject;
        }
        if (success) {
            success(task,dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf removeRequestTask:task];
        if (task.state != NSURLSessionTaskStateCanceling) {
            if (failure) {
                failure(task,[[AFNReqeustError alloc] netReqeustError:error url:url requestId:[NSNumber numberWithUnsignedInteger:task.taskIdentifier]]);
            }
        }
    }];
    return [self storeRequestTask:task];
}

#pragma mark - private method
+ (NSURLSessionDataTask *)storeRequestTask:(NSURLSessionDataTask *)task {
    [[BaseNetRequestConfig netRequestConfig].dispatchTable addObject:task];
    NSLog(@"request task %@",[BaseNetRequestConfig netRequestConfig].dispatchTable);
    return task;
}

+ (void)removeRequestTask:(NSURLSessionDataTask *)task {
    if ([[BaseNetRequestConfig netRequestConfig].dispatchTable containsObject:task]) {
        [[BaseNetRequestConfig netRequestConfig].dispatchTable removeObject:task];
    }
}

@end
