//
//  MPUserStatusGlobalModel.m
//  YiZhan
//
//  Created by YZ_BMAC on 2020/1/14.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import "MPUserStatusGlobalModel.h"

static MPUserStatusGlobalModel *statusModel = nil;

@implementation MPUserStatusGlobalModel

+ (instancetype)UserGlobalModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!statusModel) {
            statusModel = [[MPUserStatusGlobalModel alloc] init];
        }
    });
    return statusModel;
}

- (void)resetData {
    self.token = @"";
    [self.userInfoModel resetData];
    self.userInfoModel = nil;
    self.isLogin = self.token.length;
}

#pragma mark - getter
- (BOOL)isLogin {
    return self.userInfoModel.token.length;
}

- (NSString *)token {
    return _token.length ? _token : self.userInfoModel.token;
}

- (BOOL)isSecondTimeInstall {
    return [[MPUserDefaultsCache MPGetCacheValueForKey:@"newUser"] boolValue];
}

@end
