//
//  AFNReqeustError.h
//  CardGameNetRequest
//
//  Created by 刘冉 on 2017/10/23.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 自定义AFN请求类型错误码
 */
@interface AFNReqeustError : NSError

/**
 * AFNetwoking请求错误码
 * @param   error       NSError     请求返回的错误
 * @param   url         NSString    错误的请求URL
 * @param   requestId   NSNumber    请求标识
 */
-(NSError*)netReqeustError:(NSError*)error url:(NSString*)url requestId:(NSNumber *)requestId;

@end
