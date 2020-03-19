//
//  BussinessLogicError.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/15.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "BussinessLogicError.h"
#import "ErrorConfig.h"

@interface BussinessLogicError ()

/** errorType */
@property (nonatomic,assign) BusinessLogicErrorType errorType;
/** desc */
@property (nonatomic,copy) NSString *desc;

@end

@implementation BussinessLogicError

- (NSError *)bussinessLogicError:(NSInteger)errorCode url:(NSString *)url desc:(nonnull NSString *)desc requestId:(nonnull NSNumber *)requestId additionalInfo:(nonnull NSDictionary *)dict {
    self.desc = desc.length ? desc : @"未知错误";
    switch (errorCode) {
        case 300:
            self.errorType = BusinessLogicErrorType_AuthoCodeError;
            break;
        case 400:
            self.errorType = BusinessLogicErrorType_ReqeustError;
            break;
        case 414:
            self.errorType = BusinessLogicErrorType_ForceUpdateVersion;
            break;
        case 500:
            self.errorType = BusinessLogicErrorType_ServiceError;
            break;
        case 505:
            self.errorType = BusinessLogicErrorType_RefusedApplicationInTerm;
            break;
        case 999:
            self.errorType = BusinessLogicErrorType_TokenFailure;
            break;
        default:
            self.errorType = BusinessLogicErrorType_Unknown;
            self.desc = @"未知错误";
            break;
    }
    
    NSLog(@"业务逻辑错误,类型:%ld,错误原因:%@,请求URL:%@",(long)self.errorType,self.desc,url);
    NSError *error = [self createErrorDomain:self.errorType msg:self.desc requestId:requestId additionalInfo:dict];
    return error;
}

#pragma mark - 创建dommain
-(NSError*)createErrorDomain:(NSInteger)errorCode msg:(NSString*)errorMSg requestId:(NSNumber *)requestid additionalInfo:(NSDictionary *)dict{
    if (!errorMSg) {
        return nil;
    }
    return [NSError errorWithDomain:@BussinessLogicRequestDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey:errorMSg,@"requestId":requestid,@"additionalInfo":dict}];
}

@end
