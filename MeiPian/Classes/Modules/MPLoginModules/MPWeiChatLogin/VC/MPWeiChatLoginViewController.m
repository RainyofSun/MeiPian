//
//  MPWeiChatLoginViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPWeiChatLoginViewController.h"
#import "MPWeiChatLoginViewModel.h"

@interface MPWeiChatLoginViewController ()

/** WCLoginVM */
@property (nonatomic,strong) MPWeiChatLoginViewModel *WCLoginVM;

@end

@implementation MPWeiChatLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.WCLoginVM loadWeiChatLoginMainView:self];
}

#pragma mark - 消息透传
- (void)touchWeiChatLoginViewBtn:(NSNumber *)senderTag {
    [self.WCLoginVM mainViewBtnLogic:self senderTag:senderTag];
}

#pragma mark - lazy
- (MPWeiChatLoginViewModel *)WCLoginVM {
    if (!_WCLoginVM) {
        _WCLoginVM = [[MPWeiChatLoginViewModel alloc] init];
    }
    return _WCLoginVM;
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
