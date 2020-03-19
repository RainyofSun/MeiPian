//
//  AFNReqeustError.m
//  CardGameNetRequest
//
//  Created by 刘冉 on 2017/10/23.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "AFNReqeustError.h"
#import "ErrorConfig.h"

@interface AFNReqeustError()

/** errorType */
@property (nonatomic,assign) RequestErrorType errorType;
/** desc */
@property (nonatomic,copy) NSString *desc;

@end

@implementation AFNReqeustError

-(NSError*)netReqeustError:(NSError *)error url:(NSString *)url requestId:(NSNumber *)requestId{
    switch (error.code) {
        case -1:
            self.errorType = RequestErrorType_UnKown;
            self.desc = @"未知错误";
            break;
        case -1000:
            self.errorType = RequestErrorType_UrlError;
            self.desc = @"请求地址拼接错误";
            break;
        case -1001:
            self.errorType = RequestErrorType_TimerOut;
            self.desc = @"网络请求超时";
            break;
        case -1002:
            self.errorType = RequestErrorType_UnSupportedUrl;
            self.desc = @"URL请求不支持";
            break;
        case -1005:
            self.errorType = RequestErrorType_NetConnectLost;
            self.desc = @"服务连接断开";
            break;
        case -1004:
            self.errorType = RequestErrorType_ServiceConnectLost;
            self.desc = @"未能连接到服务器";
            break;
        case -1009:
            self.errorType = RequestErrorType_NoNet;
            self.desc = @"网络连接断开";
            break;
        case -1011:
            self.errorType = RequestErrorType_BadServiceRes;
            self.desc = @"请求失败,请检查参数、URL";
            break;
        case -1202:
            self.errorType = RequestErrorType_ServercertificateError;
            self.desc = @"服务器证书不正确";
            break;
        default:
            NSLog(@"请求失败 %@",error);
            self.errorType = RequestErrorType_UnKown;
            self.desc = @"未知错误";
            break;
    }
    NSLog(@"网络请求错误,类型:%ld,错误原因:%@,请求URL:%@",(long)self.errorType,self.desc,url);
    NSError *netError = [self createErrorDomain:self.errorType msg:self.desc requestId:requestId];
    return netError;
}

#pragma mark - 创建dommain
-(NSError*)createErrorDomain:(NSInteger)errorCode msg:(NSString*)errorMSg requestId:(NSNumber *)requestid{
    if (!errorMSg) {
        return nil;
    }
    return [NSError errorWithDomain:@AFNDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey:errorMSg,@"requestId":requestid}];
}

@end
