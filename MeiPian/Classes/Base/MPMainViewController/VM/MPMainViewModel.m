//
//  MPMainViewModel.m
//  MeiPian
//
//  Created by MP_BMAC on 2020/3/9.
//  Copyright © 2020 MP_BMAC. All rights reserved.
//

#import "MPMainViewModel.h"
#import "MPTabBarViewController.h"
#import "MPNavigationViewController.h"
#import "MPWeiChatLoginViewController.h"
#import "MPAdvertisingViewModel.h"

static NSInteger tokenExpireTime = 54000000;

@interface MPMainViewModel ()

/** adVM */
@property (nonatomic,strong) MPAdvertisingViewModel *adVM;

@end

@implementation MPMainViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 配置tabbar
- (void)loadTabBarController:(UIViewController *)vc {
    [MPUserInfoCache getCacheUserModel];
    MPTabBarViewController *tabBar = [[MPTabBarViewController alloc] init];
    [vc.view addSubview:tabBar.view];
    [vc addChildViewController:tabBar];
    tabBar.view.translatesAutoresizingMaskIntoConstraints = NO;
    [tabBar.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

// 展示广告页
- (void)showAdView:(UIViewController *)vc {
    WeakSelf;
    [self.adVM showAdvertisingViewDisBlock:^(BOOL isLinkAD) {
        [weakSelf whetherUserNeedLogin:vc];
        UITableViewController *tabVC = (UITableViewController *)vc.childViewControllers.firstObject;
        UINavigationController *nav = (UINavigationController *)tabVC.childViewControllers.firstObject;
        [MPModulesMsgSend sendCumtomMethodMsg:nav.topViewController methodName:@selector(sendHomePageRequest)];
        if (isLinkAD) {
            [MPModulesMsgSend sendCumtomMethodMsg:nav.topViewController methodName:@selector(showAdLink)];
        }
        weakSelf.adVM = nil;
    }];
}

#pragma mark - private methods
// 用户是否需要重新登录
- (void)whetherUserNeedLogin:(UIViewController *)vc {
    [MPUserInfoCache getCacheUserModel];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"newUser"];
    if (![MPUserStatusGlobalModel UserGlobalModel].isSecondTimeInstall) {
        // 首次安装等待结束新手引导结束之后再显示登录
        return;
    }
    if (![MPUserStatusGlobalModel UserGlobalModel].isLogin) {
        [self loadSignInNavController:vc];
    } else {
        [self loginExpireOrNot:vc];
    }
}

// 检测登录是否过期
- (void)loginExpireOrNot:(UIViewController *)vc {
    NSLog(@"userModel %@",[MPUserStatusGlobalModel UserGlobalModel].userInfoModel);
    if ([MPUserStatusGlobalModel UserGlobalModel].userInfoModel && [MPUserStatusGlobalModel UserGlobalModel].isLogin) {
        long long time = [self getNowTimestamp];
        long long serviceTime = [MPUserStatusGlobalModel UserGlobalModel].userInfoModel.tokenTimesTamp.longLongValue;
        if ((time - serviceTime) > tokenExpireTime) {
            [[MPUserStatusGlobalModel UserGlobalModel] resetData];
            [MPUserInfoCache deleteCacheUser];
            WeakSelf;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"token已过期,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf loadSignInNavController:vc];
                });
            }];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancleAction];
            [alert addAction:sureAction];
            [vc presentViewController:alert animated:YES completion:nil];
        } else {
            NSLog(@"登录未超时");
        }
    } else {
        NSLog(@"未登录");
    }
}

// 配置登录页面
- (void)loadSignInNavController:(UIViewController *)vc {
    MPWeiChatLoginViewController *signInVC = [[MPWeiChatLoginViewController alloc] initWithNibName:@"MPWeiChatLoginViewController" bundle:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vc presentNavVC:signInVC];
    });
}

#pragma mark - lazy
- (MPAdvertisingViewModel *)adVM {
    if (!_adVM) {
        _adVM = [[MPAdvertisingViewModel alloc] init];
    }
    return _adVM;
}

@end
