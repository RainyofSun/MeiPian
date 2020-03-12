//
//  TelephoneAreaCodeViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "TelephoneAreaCodeViewController.h"
#import "TelephoneCodeViewModel.h"

@interface TelephoneAreaCodeViewController ()

/** telephoneCodeVM */
@property (nonatomic,strong) TelephoneCodeViewModel *telephoneCodeVM;

@end

@implementation TelephoneAreaCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.telephoneCodeVM loadTelephoneCodeMainView:self];
    [self.telephoneCodeVM setNavItems:self];
    [self blockCallBack];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)blockCallBack {
    __weak typeof(self) weakSelf = self;
    self.telephoneCodeVM.disCallBack = ^(NSString * _Nonnull areaCode) {
        [weakSelf.telephoneCodeVM sendMsgToCaller:areaCode callee:weakSelf];
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
}

#pragma mark - lazy
- (TelephoneCodeViewModel *)telephoneCodeVM {
    if (!_telephoneCodeVM) {
        _telephoneCodeVM = [[TelephoneCodeViewModel alloc] init];
    }
    return _telephoneCodeVM;
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
