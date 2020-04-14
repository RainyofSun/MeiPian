//
//  MPMessagePageViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMessagePageViewController.h"
#import "MPMessagePageViewModel.h"

@interface MPMessagePageViewController ()

/** messageVM */
@property (nonatomic,strong) MPMessagePageViewModel *messageVM;

@end

@implementation MPMessagePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.messageVM loadMessageMainView:self];
    [self.messageVM setMessageViewNavItem:self];
}

#pragma mark - 消息透传
- (void)reloadPageData {
    NSLog(@"刷新JJ请求");
}

// 点击消息类型
- (void)selectedMessageType:(NSNumber *)senderTag {
    NSLog(@"点击消息 %@",senderTag);
}

#pragma mark - lazy
- (MPMessagePageViewModel *)messageVM {
    if (!_messageVM) {
        _messageVM = [[MPMessagePageViewModel alloc] init];
    }
    return _messageVM;
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
