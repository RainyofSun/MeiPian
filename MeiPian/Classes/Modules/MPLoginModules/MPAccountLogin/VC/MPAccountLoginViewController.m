//
//  MPAccountLoginViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAccountLoginViewController.h"
#import "MPAccountLoginViewModel.h"

@interface MPAccountLoginViewController ()

/** accountLoginVM */
@property (nonatomic,strong) MPAccountLoginViewModel *accountLoginVM;

@end

@implementation MPAccountLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.accountLoginVM loadAccountLoginMainView:self];
}

#pragma mark - 消息透传
- (void)touchAccountLoginViewBtn:(NSNumber *)senderTag {
    [self.accountLoginVM mainViewBtnLogic:self senderTag:senderTag];
}

#pragma mark - lazy
- (MPAccountLoginViewModel *)accountLoginVM {
    if (!_accountLoginVM) {
        _accountLoginVM = [[MPAccountLoginViewModel alloc] init];
    }
    return _accountLoginVM;
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
