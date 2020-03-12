//
//  TelephoneCodeViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TelephoneCodeViewModel : NSObject

/** disCallBack */
@property (nonatomic,copy) void (^disCallBack)(NSString *areaCode);

/// 加载主界面
- (void)loadTelephoneCodeMainView:(UIViewController *)vc;
/// 设置Nav
- (void)setNavItems:(UIViewController *)vc;
/// 给控件调用者发送消息 --->调用者务必实现此方法:updateAreaCode:(NSString *)code,否则点击会崩溃
- (void)sendMsgToCaller:(NSString *)msg callee:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
