//
//  BussinessLogicError.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/15.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BussinessLogicError : NSError

/**
 * AFNetwoking请求错误码
 * @param   errorCode   NSInteger     请求返回的错误
 * @param   url         NSString      错误的请求URL
 * @param   desc        NSString      错误信息
 * @param   requestId   NSNumber      请求标识
 * @param   dict        NSDictionary  错误额外信息
 */
-(NSError*)bussinessLogicError:(NSInteger)errorCode url:(NSString*)url desc:(NSString *)desc requestId:(NSNumber *)requestId additionalInfo:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
