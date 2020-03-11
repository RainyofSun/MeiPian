//
//  MPPhoneLoginViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPPhoneLoginViewModel.h"
#import "MPPhoneLoginView.h"

@implementation MPPhoneLoginViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 账号登录主界面
- (void)loadAccountLoginMainView:(UIViewController *)vc {
    [vc setNavHiden:YES];
    MPPhoneLoginView *phoneView = [[[NSBundle mainBundle] loadNibNamed:@"MPPhoneLoginView" owner:nil options:nil] firstObject];
    [vc.view addSubview:phoneView];
    [phoneView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag {
    switch (senderTag.integerValue) {
        case 0:
            [vc.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            
            break;
        default:
            break;
    }
}

@end
