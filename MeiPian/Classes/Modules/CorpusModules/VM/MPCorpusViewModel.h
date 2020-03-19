//
//  MPCorpusViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCorpusViewModel : MPBaseViewModel

/// 加载主界面
- (void)loadCorpusMainView:(UIViewController *)vc;
/// 界面点击回调
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag;

@end

NS_ASSUME_NONNULL_END
