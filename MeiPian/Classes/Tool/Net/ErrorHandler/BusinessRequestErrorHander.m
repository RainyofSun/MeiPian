//
//  BusinessRequestErrorHander.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/9/4.
//  Copyright © 2019 MP_BMAC. All rights reserved.
//

#import "BusinessRequestErrorHander.h"
#import "ErrorConfig.h"

@implementation BusinessRequestErrorHander

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (void)bussinessRequestHander:(NSError *)error {
    [MBHUDToastManager hideAlert];
    if (error.code == BusinessLogicErrorType_TokenFailure) {
        [[MPUserStatusGlobalModel UserGlobalModel] resetData];
        [MPUserInfoCache deleteCacheUser];
    }
    if (error.code == BusinessLogicErrorType_ForceUpdateVersion) {
        // 强制更新
        [self forceUpdateVersion:error];
    }
}

+ (void)backLogin:(UIViewController *)topVC {
    Class loginVC = NSClassFromString(@"MPLoginViewController");
    if ([topVC isKindOfClass:loginVC]) {
        [topVC.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    [topVC presentNavVC:@"MPLoginViewController"];
}

+ (void)forceUpdateVersion:(NSError * _Nonnull)error {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *dict = [error.userInfo objectForKey:@"additionalInfo"];
    });
}

@end
