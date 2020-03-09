//
//  MPMainViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMainViewModel : MPBaseViewModel

/// rootVC 判断
- (void)whetherUserNeedLogin:(UIViewController *)vc;
/// 配置tabbar
- (void)loadTabBarController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
