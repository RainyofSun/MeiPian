//
//  MPSMSCodeViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SMSCodeViewStyle_PhoneLogin,
    SMSCodeViewStyle_ForgetPWD,
} SMSCodeViewStyle;

@interface MPSMSCodeViewModel : MPBaseViewModel

/** phone */
@property (nonatomic,strong) NSString *phone;
/** viewStyle */
@property (nonatomic,assign) SMSCodeViewStyle viewStyle;

/// 加载短验登录界面
- (void)loadSMSCodeMainView:(UIViewController *)vc;
/// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag;
/// 请求验证码
- (void)requestSMSCode:(UIViewController *)vc;
/// 添加/删除textFiled的监听通知
- (void)addOrDeleteTextFiledObserver:(BOOL)isAdd;

@end

NS_ASSUME_NONNULL_END
