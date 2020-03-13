//
//  MPForgetPWDViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPForgetPWDViewController.h"
#import "MPForgetPWDViewModel.h"

@interface MPForgetPWDViewController ()

/** forgetPWDVM */
@property (nonatomic,strong) MPForgetPWDViewModel *forgetPWDVM;

@end

@implementation MPForgetPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.forgetPWDVM loadForgetPWDMainView:self];
}

#pragma mark - 消息c透传
- (void)touchForgetPWDViewBtn:(NSNumber *)senderTag {
    [self.forgetPWDVM mainViewBtnLogic:self senderTag:senderTag];
}

// 选择电话区号
- (void)selectedCountryPhoneCode {
    [self presentNavVC:@"TelephoneAreaCodeViewController"];
}

// 更新电话区号
- (void)updateAreaCode:(NSString *)code {
    [self.forgetPWDVM updateAreaCode:code];
}

#pragma mark - public methods
- (MPForgetPWDViewModel *)forgetPWDVM {
    if (!_forgetPWDVM) {
        _forgetPWDVM = [[MPForgetPWDViewModel alloc] init];
    }
    return _forgetPWDVM;
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
