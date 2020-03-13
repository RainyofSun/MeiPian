//
//  MPSMSCodeViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPSMSCodeViewController.h"
#import "MPSMSCodeViewModel.h"

@interface MPSMSCodeViewController ()

/** smsCodeVM */
@property (nonatomic,strong) MPSMSCodeViewModel *smsCodeVM;

@end

@implementation MPSMSCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.smsCodeVM loadSMSCodeMainView:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.smsCodeVM addOrDeleteTextFiledObserver:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.smsCodeVM addOrDeleteTextFiledObserver:NO];
}

#pragma mark - 消息透传
- (void)modulesSendMsg:(id)params {
    if ([params isKindOfClass:[NSDictionary class]]) {
        NSLog(@"短信验证码 %@",params);
        self.smsCodeVM.phone = [params objectForKey:@"phone"];
        self.smsCodeVM.viewStyle = [[params objectForKey:@"isForgetPwd"] integerValue];
    }
}

- (void)touchSMSCodeViewBtn:(NSNumber *)senderTag {
    [self.smsCodeVM mainViewBtnLogic:self senderTag:senderTag];
}

- (void)touchSMSCodeBtn {
    [self.smsCodeVM requestSMSCode:self];
}

#pragma mark - lazy
- (MPSMSCodeViewModel *)smsCodeVM {
    if (!_smsCodeVM) {
        _smsCodeVM = [[MPSMSCodeViewModel alloc] init];
    }
    return _smsCodeVM;
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
