//
//  BaseNetRequestConfig.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/25.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNetRequestConfig : NSObject

+ (instancetype)netRequestConfig;

- (void)setRequestHeader:(NSDictionary *)params;

/** 需要上传的图片 */
@property (nonatomic,strong) NSData *uploadImg;
/** 网络请求管理 */
@property (nonatomic,strong) AFHTTPSessionManager* manager;
/** 存放 task */
@property (nonatomic,strong) NSMutableArray <NSURLSessionDataTask *>*dispatchTable;

@end

NS_ASSUME_NONNULL_END
