//
//  MPCirclePageViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCirclePageViewModel : MPBaseViewModel

/// 加载主界面
- (void)loadMainCirclePageView:(UIViewController *)vc;
/// 创建NavItems
- (void)setupCircleNavItems:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
