//
//  MPNetRequestManager.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPNetRequestManager.h"
#import "BaseNetWorkingRequest.h"
#import "BussinessLogicError.h"
#import "BusinessRequestErrorHander.h"

static NSInteger forceUpdateAppCode = 414;  // 强制更新app

@implementation MPNetRequestManager

+ (NSURLSessionDataTask *)EGLSNetRequestType:(AFNRequestType)requestType requestUrl:(NSString *)url requestParams:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)failure{
    return [BaseNetWorkingRequest AFNReqeustType:requestType reqesutUrl:url params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSDictionary *verifyData = (NSDictionary *)responseObject;
            NSLog(@"服务器返回数据 %@",verifyData);
            if ([[verifyData objectForKey:@"code"] integerValue] == 200) {
                if (success) {
                    success(task,[verifyData objectForKey:@"data"]);
                }
            } else {
                NSDictionary *additionalInfo = [verifyData.allKeys containsObject:@"data"] ? [verifyData objectForKey:@"data"] : @{};
                // 拦截token错误
                [BusinessRequestErrorHander bussinessRequestHander:[[BussinessLogicError alloc] bussinessLogicError:[[verifyData objectForKey:@"code"] integerValue] url:url desc:[verifyData objectForKey:@"msg"] requestId:[NSNumber numberWithUnsignedInteger:task.taskIdentifier] additionalInfo:additionalInfo]];
                if (failure && ([[verifyData objectForKey:@"code"] integerValue] != forceUpdateAppCode)) {
                    failure(task,[[BussinessLogicError alloc] bussinessLogicError:[[verifyData objectForKey:@"code"] integerValue] url:url desc:[verifyData objectForKey:@"msg"] requestId:[NSNumber numberWithUnsignedInteger:task.taskIdentifier] additionalInfo:additionalInfo]);
                }
            }
        }
    } failure:failure];
}

+ (NSURLSessionDataTask *)EGLSNetRequestType:(AFNRequestType)requestType reqesutUrl:(NSString *)url params:(NSDictionary *)params img:(NSData *)uploadImg success:(SuccessCallBack)success failure:(FailureCallBack)failure{
    return [BaseNetWorkingRequest AFNReqeustType:requestType reqesutUrl:url params:params img:uploadImg success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            NSDictionary *verifyData = (NSDictionary *)responseObject;
            if ([[verifyData objectForKey:@"code"] integerValue] == 200) {
                if (success) {
                    success(task,[verifyData objectForKey:@"data"]);
                }
            } else {
                NSDictionary *additionalInfo = [verifyData.allKeys containsObject:@"data"] ? [verifyData objectForKey:@"data"] : @{};
                // 拦截token错误
                [BusinessRequestErrorHander bussinessRequestHander:[[BussinessLogicError alloc] bussinessLogicError:[[verifyData objectForKey:@"code"] integerValue] url:url desc:[verifyData objectForKey:@"msg"] requestId:[NSNumber numberWithUnsignedInteger:task.taskIdentifier] additionalInfo:additionalInfo]];
                if (failure && ([[verifyData objectForKey:@"code"] integerValue] != forceUpdateAppCode)) {
                    failure(task,[[BussinessLogicError alloc] bussinessLogicError:[[verifyData objectForKey:@"code"] integerValue] url:url desc:[verifyData objectForKey:@"msg"] requestId:[NSNumber numberWithUnsignedInteger:task.taskIdentifier] additionalInfo:additionalInfo]);
                }
            }
        }
    } failure:failure];
}

+ (void)EGLSCancelRequestWithRequestTask:(NSURLSessionDataTask *)requestTask {
    [BaseNetWorkingRequest cancelRequestWithRequestTask:requestTask];
}

+ (void)EGLSCancelRequestWithRequestTaskList:(NSArray<NSURLSessionDataTask *> *)requestTaskList {
    [BaseNetWorkingRequest cancelRequestWithRequestTaskList:requestTaskList];
}

@end
