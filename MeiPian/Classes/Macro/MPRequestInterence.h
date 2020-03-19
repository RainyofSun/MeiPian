//
//  MPRequestInterence.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#ifndef MPRequestInterence_h
#define MPRequestInterence_h

#pragma mark - H5与原生定义方法名
#define SEL_NAME_POST_MSG   @"postQuery"
#define HostURL             @"https://api.meipian.me/"
/// 推荐全部
#define RecommondAllArticle @"5.5/discovery/index"
/// 获取广告信息
#define ADMsg_URL           @"5.5/article/shareAd"

#pragma mark - 登录接口
/// 登录获取短信
#define LOGIN_SMS_CODE      @"/5.5/sms/fetch"

#endif /* MPRequestInterence_h */
