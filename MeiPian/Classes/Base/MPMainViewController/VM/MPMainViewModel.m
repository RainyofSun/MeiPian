//
//  MPMainViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMainViewModel.h"
#import "MPTabBarViewController.h"
#import "MPNavigationViewController.h"
#import "MPWeiChatLoginViewController.h"

@implementation MPMainViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 用户是否需要重新登录
- (void)whetherUserNeedLogin:(UIViewController *)vc {
    if (![MPUserStatusGlobalModel UserGlobalModel].isSecondTimeInstall) {
        // 首次安装等待结束新手引导结束之后再显示登录
        return;
    }
    if (![MPUserStatusGlobalModel UserGlobalModel].isLogin) {
        [self loadSignInNavController:vc];
    }
}

// 配置tabbar
- (void)loadTabBarController:(UIViewController *)vc {
    [MPUserInfoCache getCacheUserModel];
    MPTabBarViewController *tabBar = [[MPTabBarViewController alloc] init];
    [vc.view addSubview:tabBar.view];
    [vc addChildViewController:tabBar];
    tabBar.view.translatesAutoresizingMaskIntoConstraints = NO;
    [tabBar.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark - private methods
// 检测登录是否过期
- (void)loginExpireOrNot:(UIViewController *)vc {
    
}

// 配置登录页面
- (void)loadSignInNavController:(UIViewController *)vc {
    MPWeiChatLoginViewController *signInVC = [[MPWeiChatLoginViewController alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vc presentNavVC:signInVC];
    });
}

@end
