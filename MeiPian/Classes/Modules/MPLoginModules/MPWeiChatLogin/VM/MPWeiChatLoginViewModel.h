//
//  MPWeiChatLoginViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPWeiChatLoginViewModel : MPBaseViewModel

/// 加载微信登录的主界面
- (void)loadWeiChatLoginMainView:(UIViewController *)vc;
/// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag;
/// 切花登录方式
- (void)switchLoginWay:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
