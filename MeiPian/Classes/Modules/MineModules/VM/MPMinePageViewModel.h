//
//  MPMinePageViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMinePageViewModel : MPBaseViewModel

/// 加载主界面
- (void)loadMinePageMainView:(UIViewController *)vc;
/// 创建NavItem
- (void)setMineViewNavItem:(UIViewController *)vc;
/// 创建NavTitle
- (void)setMineNavTitleView:(UIViewController *)vc withUserInfo:(NSDictionary *)userInfo;
/// 显示/隐藏NavTitleView
- (void)controlNavTitleViewShowOrHide:(NSNumber *)contentOffsetY;

@end

NS_ASSUME_NONNULL_END
