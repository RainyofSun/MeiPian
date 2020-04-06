//
//  MPHomePageSubViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPHomePageSubViewController.h"

@interface MPHomePageSubViewController ()

@end

@implementation MPHomePageSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 消息透传
- (void)selectArticleType:(NSNumber *)senderTag {
    NSLog(@"消息透传 %@",senderTag);
}

#pragma mark - public methods
- (void)addHomePageSubView:(UIView *)subView {
    [self.view addSubview:subView];
    [subView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
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
