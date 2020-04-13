//
//  MPMessagePageViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMessagePageViewModel.h"
#import "MPMessagePageView.h"

@interface MPMessagePageViewModel ()

/** pageView */
@property (nonatomic,strong) MPMessagePageView *pageView;

@end

@implementation MPMessagePageViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载主界面
- (void)loadMessageMainView:(UIViewController *)vc {
    [vc setNavHiden:NO];
    vc.title = @"消息";
    self.pageView = [[MPMessagePageView alloc] init];
    [vc.view addSubview:self.pageView];
    [self.pageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

// 创建navitem
- (void)setMessageViewNavItem:(UIViewController *)vc {
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftItem setTitle:@"找好友" forState:UIControlStateNormal];
    [leftItem setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(touchNavItem:) forControlEvents:UIControlEventTouchUpInside];
    [vc setNavigationLeftView:leftItem];
}

- (void)touchNavItem:(UIButton *)sender {
    
}

@end
