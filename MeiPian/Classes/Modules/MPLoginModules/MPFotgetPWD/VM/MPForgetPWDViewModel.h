//
//  MPForgetPWDViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPForgetPWDViewModel : MPBaseViewModel

/// 加载主界面
- (void)loadForgetPWDMainView:(UIViewController *)vc;
/// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag;
/// 更新电话区号
- (void)updateAreaCode:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
