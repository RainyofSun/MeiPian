//
//  MPMessagePageViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMessagePageViewModel : MPBaseViewModel

/// 加载消息的主界面
- (void)loadMessageMainView:(UIViewController *)vc;
/// 创建NavItem
- (void)setMessageViewNavItem:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
