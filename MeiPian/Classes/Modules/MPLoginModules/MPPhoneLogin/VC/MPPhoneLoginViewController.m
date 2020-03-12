//
//  MPPhoneLoginViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPPhoneLoginViewController.h"
#import "MPPhoneLoginViewModel.h"
#import "TelephoneAreaCodeViewController.h"

@interface MPPhoneLoginViewController ()

/** phoneLoginVM */
@property (nonatomic,strong) MPPhoneLoginViewModel *phoneLoginVM;

@end

@implementation MPPhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.phoneLoginVM loadAccountLoginMainView:self];
}

#pragma mark - 消息透传
- (void)touchPhoneLoginViewBtn:(NSNumber *)senderTag {
    [self.phoneLoginVM mainViewBtnLogic:self senderTag:senderTag];
}

// 选择电话区号
- (void)selectedCountryPhoneCode {
    [self presentNavVC:@"TelephoneAreaCodeViewController"];
}

// 更新电话区号
- (void)updateAreaCode:(NSString *)code {
    [self.phoneLoginVM updateAreaCode:code];
}

#pragma mark - lazy
- (MPPhoneLoginViewModel *)phoneLoginVM {
    if (!_phoneLoginVM) {
        _phoneLoginVM = [[MPPhoneLoginViewModel alloc] init];
    }
    return _phoneLoginVM;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
