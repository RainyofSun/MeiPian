//
//  BaseNetWorkingRequest.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/15.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetRequestConfig.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 封装AFN请求
 */

@interface BaseNetWorkingRequest : NSObject

/**
 * @brief                                 基本数据请求
 * @param   requestType AFNRequestType    数据请求类型
 * @param   url         NSString          请求地址
 * @param   params      NSDictionary      请求参数
 * @param   success     SuccessCallBack   成功返回
 * @param   failure     FailureCallBack   失败返回
 * @return              NSURLSessionDataTask          请求标识
 */
+ (NSURLSessionDataTask *)AFNReqeustType:(AFNRequestType)requestType reqesutUrl:(NSString*)url params:(NSDictionary*)params success:(SuccessCallBack)success failure:(FailureCallBack)failure;

/**
 * @brief                                 上传图片
 * @param   requestType AFNRequestType    数据请求类型
 * @param   url         NSString          请求地址
 * @param   params      NSDictionary      请求参数
 * @param   uploadImg   UIImage           需要上传的图片
 * @param   success     SuccessCallBack   成功返回
 * @param   failure     FailureCallBack   失败返回
 * @return              NSURLSessionDataTask          请求标识
 */
+ (NSURLSessionDataTask *)AFNReqeustType:(AFNRequestType)requestType reqesutUrl:(NSString *)url params:(NSDictionary *)params img:(NSData *)uploadImg success:(SuccessCallBack)success failure:(FailureCallBack)failure;

/**
 * @brief                                             取消单个请求
 * @param   requestTask   NSURLSessionDataTask        数据请求类型
 */
+ (void)cancelRequestWithRequestTask:(NSURLSessionDataTask *)requestTask;

/**
 * @brief                                 批量取消请求
 * @param   requestTaskList   NSArray     数据请求类型
 */
+ (void)cancelRequestWithRequestTaskList:(NSArray<NSURLSessionDataTask *> *)requestTaskList;

@end

NS_ASSUME_NONNULL_END
