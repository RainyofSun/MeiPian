//
//  MPUserInfoCache.h
//  MeiPian
//
//  Created by 刘冉 on 2019/9/3.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPUserInfoCache : NSObject

/// 序列化用户信息
+ (void)saveCacheUserinfoModel;
/// 获取用户信息
+ (void)getCacheUserModel;
/// 删除用户信息
+ (void)deleteCacheUser;

@end

NS_ASSUME_NONNULL_END
