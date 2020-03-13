//
//  MPForgetPWDViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPForgetPWDViewModel.h"
#import "MPForgetPWDView.h"

@interface MPForgetPWDViewModel ()

/** forgetView */
@property (nonatomic,strong) MPForgetPWDView *forgetView;

@end

@implementation MPForgetPWDViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载主界面
- (void)loadForgetPWDMainView:(UIViewController *)vc {
    self.forgetView = [[[NSBundle mainBundle] loadNibNamed:@"MPForgetPWDView" owner:nil options:nil] firstObject];
    [vc.view addSubview:self.forgetView];
    [self.forgetView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [vc setNavHiden:YES];
}

// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag {
    switch (senderTag.integerValue) {
        case 0:
            [vc.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            if (![[self.forgetView getPhoneNum] isValidateMobileNumber]) {
                [MBHUDToastManager showBriefAlert:@"请输入正确的手机号码"];
                return;
            }
            [vc pushVC:[MPModulesMsgSend sendMsg:@{@"phone":[self.forgetView getPhoneNum],@"isForgetPwd":@(YES)} vcName:@"MPSMSCodeViewController"]];
            break;
        default:
            break;
    }
}

// 更新电话区号
- (void)updateAreaCode:(NSString *)code {
    if (!code.length) {
        return;
    }
    [self.forgetView reloadPhoneAreaCode:code];
}

@end
