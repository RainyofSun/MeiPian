//
//  MPUserStatusGlobalModel.h
//  YiZhan
//
//  Created by YZ_BMAC on 2020/1/14.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPUserInfoModel.h"

@interface MPUserStatusGlobalModel : MPBaseModel

/**
 * 全局单利
 * @brief 存放用户需要全局使用的参数：是否登录等
 */
+ (instancetype)UserGlobalModel;

/** token */
@property (nonatomic,strong) NSString *token;

/** userInfoModel */
@property (nonatomic,strong) MPUserInfoModel *userInfoModel;
/** isLogin */
@property (nonatomic,assign) BOOL isLogin;
/** isFirstInstall */
@property (nonatomic,assign) BOOL isSecondTimeInstall;
/** isRealNameAuthen */
@property (nonatomic,assign) BOOL isRealNameAuthen;

- (void)resetData;

@end

