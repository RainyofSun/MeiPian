//
//  ErrorConfig.h
//  CardGameNetRequest
//
//  Created by 刘冉 on 2017/10/23.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#ifndef ErrorConfig_h
#define ErrorConfig_h

/// AFN请求错误Domain
#define AFNDomain               "AFN.ErrorDomain"

/**
 * AFN 请求错误类型
 */
typedef NS_ENUM(NSInteger,RequestErrorType) {
    RequestErrorType_NetNotReachable = 100, /// 网络不可用
    RequestErrorType_UnKown = 1000,         /// 未知错误
    RequestErrorType_NoNet = 1001,          /// 网络错误
    RequestErrorType_UrlError,              /// 请求地址错误
    RequestErrorType_TimerOut,              /// 请求超时
    RequestErrorType_UnSupportedUrl,        /// URL不支持
    RequestErrorType_NetConnectLost,        /// 网络连接断开
    RequestErrorType_ServiceConnectLost,    /// 未能连接到服务器
    RequestErrorType_BadServiceRes,         /// 服务器反馈数据错误
    RequestErrorType_ServercertificateError /// 服务器证书不匹配
};

/// 基本请求错误Domain
#define BussinessLogicRequestDomain    "BussinessRequest.ErrorDomain"

/**
 * 业务逻辑错误
 */
typedef NS_ENUM(NSInteger,BusinessLogicErrorType) {
    /// 未知错误
    BusinessLogicErrorType_Unknown = 0,
    /// 验证码错误
    BusinessLogicErrorType_AuthoCodeError = 300,
    /// 请求错误
    BusinessLogicErrorType_ReqeustError = 400,
    /// 强制更新
    BusinessLogicErrorType_ForceUpdateVersion = 414,
    /// 系统出错了
    BusinessLogicErrorType_ServiceError = 500,
    /// 30天内审批拒绝过
    BusinessLogicErrorType_RefusedApplicationInTerm = 505,
    /// token失效、过期、踢出、不存在
    BusinessLogicErrorType_TokenFailure = 999
};

#endif /* ErrorConfig_h */
