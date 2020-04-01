//
//  MPHomePageMainViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPHomePageMainViewModel : MPBaseViewModel

/// 加载顶部页面控制
- (void)loadTopPageControl:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
