//
//  MPPhoneLoginViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPPhoneLoginViewModel : MPBaseViewModel

/// 手机号登录主界面
- (void)loadAccountLoginMainView:(UIViewController *)vc;
/// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag;
/// 更新电话区号
- (void)updateAreaCode:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
