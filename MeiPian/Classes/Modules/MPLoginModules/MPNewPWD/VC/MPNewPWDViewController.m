//
//  MPNewPWDViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPNewPWDViewController.h"
#import "MPNewPWDViewModel.h"

@interface MPNewPWDViewController ()

/** pwdVM */
@property (nonatomic,strong) MPNewPWDViewModel *pwdVM;

@end

@implementation MPNewPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.pwdVM loadNewPWDMainView:self];
}

#pragma mark - 消息透传
- (void)modulesSendMsg:(id)params {
    if ([params isKindOfClass:[NSString class]]) {
        NSLog(@"短信验证码 %@",params);
        self.pwdVM.phone = params;
    }
}

- (void)touchNewPWDViewBtn:(NSNumber *)senderTag {
    [self.pwdVM mainViewBtnLogic:self senderTag:senderTag];
}

#pragma mark - lazy
- (MPNewPWDViewModel *)pwdVM {
    if (!_pwdVM) {
        _pwdVM = [[MPNewPWDViewModel alloc] init];
    }
    return _pwdVM;
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
