//
//  MPCirclePageViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/7.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCirclePageViewModel.h"
#import "MPCirclePageView.h"

@interface MPCirclePageViewModel ()

/** circleView */
@property (nonatomic,strong) MPCirclePageView *circleView;

@end

@implementation MPCirclePageViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载主界面
- (void)loadMainCirclePageView:(UIViewController *)vc {
    vc.title = @"圈子";
    [vc setNavHiden:NO];
    self.circleView = [[MPCirclePageView alloc] init];
    [vc.view addSubview:self.circleView];
    [self.circleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

// 创建NavItems
- (void)setupCircleNavItems:(UIViewController *)vc {
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.tag = 0;
    [leftItem setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    leftItem.frame = CGRectMake(0, 0, 44, 44);
    [leftItem addTarget:self action:@selector(touchNavItems:) forControlEvents:UIControlEventTouchUpInside];
    [vc setNavigationLeftView:leftItem];
    
    UIButton *right0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [right0 setImage:[UIImage imageNamed:@"circle_talk_icon"] forState:UIControlStateNormal];
    [right0 addTarget:self action:@selector(touchNavItems:) forControlEvents:UIControlEventTouchUpInside];
    right0.frame = CGRectMake(0, 0, 50, 44);
    right0.tag = 1;
    
    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [right1 setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [right1 addTarget:self action:@selector(touchNavItems:) forControlEvents:UIControlEventTouchUpInside];
    right1.frame = CGRectMake(0, 0, 50, 44);
    right1.tag = 2;
    [vc setNavigationRightViews:@[right0,right1]];
}

#pragma mark - 点击NavItem
- (void)touchNavItems:(UIButton *)sender {
    NSLog(@"nav %ld",(long)sender.tag);
}

@end
