//
//  MPUserInfoCache.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/9/3.
//  Copyright © 2019 MP_BMAC. All rights reserved.
//

#import "MPUserInfoCache.h"

static NSString * acountFileName = @"Account.data";

@implementation MPUserInfoCache

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (void)saveCacheUserinfoModel {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject];
    NSString *accountPath = [documentPath stringByAppendingPathComponent:acountFileName];
    [NSKeyedArchiver archiveRootObject:[MPUserStatusGlobalModel UserGlobalModel].userInfoModel toFile:accountPath];
}

+ (void)getCacheUserModel{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject];
    NSString *accountPath = [documentPath stringByAppendingPathComponent:acountFileName];
    [MPUserStatusGlobalModel UserGlobalModel].userInfoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
}

+ (void)deleteCacheUser {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject];
    NSString *accountPath = [documentPath stringByAppendingPathComponent:acountFileName];
    Class modelClass = NSClassFromString(@"MPUserInfoModel");
    [NSKeyedArchiver archiveRootObject:[modelClass new] toFile:accountPath];
}

@end
