//
//  NetRequestConfig.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/15.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#ifndef NetRequestConfig_h
#define NetRequestConfig_h

/**
 * 网络请求类型
 */
typedef NS_ENUM(NSInteger,AFNRequestType) {
    AFNRequestType_Get,             /// get请求
    AFNRequestType_Post,            /// post请求
    AFNRequestType_Upload,          /// 上传图片
};

/*
    block 回调
 */
typedef void(^ _Nonnull SuccessCallBack)(NSURLSessionDataTask * _Nullable task, id _Nonnull responseObject);
typedef void(^ _Nullable FailureCallBack)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error);

#endif /* NetRequestConfig_h */
