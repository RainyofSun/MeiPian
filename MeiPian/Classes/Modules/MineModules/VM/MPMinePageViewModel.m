//
//  MPMinePageViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMinePageViewModel.h"
#import "MPMinePageView.h"

@interface MPMinePageViewModel ()

/** mineView */
@property (nonatomic,strong) MPMinePageView *mineView;

@end

@implementation MPMinePageViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载主界面
- (void)loadMinePageMainView:(UIViewController *)vc {
    [vc setNavHiden:NO];
    [vc.view addSubview:self.mineView];
    [self.mineView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

// 创建NavItem
- (void)setMineViewNavItem:(UIViewController *)vc {
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.tag = 0;
    [leftItem setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    leftItem.frame = CGRectMake(0, 0, 44, 44);
    [leftItem addTarget:self action:@selector(touchNavItems:) forControlEvents:UIControlEventTouchUpInside];
    [vc setNavigationLeftView:leftItem];
    
    UIButton *right0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [right0 setImage:[UIImage imageNamed:@"print_icon_large_0711"] forState:UIControlStateNormal];
    [right0 addTarget:self action:@selector(touchNavItems:) forControlEvents:UIControlEventTouchUpInside];
    right0.frame = CGRectMake(0, 7, right0.currentImage.size.width, right0.currentImage.size.height);
    right0.tag = 1;
    
    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [right1 setImage:[UIImage imageNamed:@"nav_icon_rightslip"] forState:UIControlStateNormal];
    [right1 addTarget:self action:@selector(touchNavItems:) forControlEvents:UIControlEventTouchUpInside];
    right1.frame = CGRectMake(right0.currentImage.size.width + 10, 0, right1.currentImage.size.width, 44);
    right1.tag = 2;
    
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, right0.currentImage.size.width + right1.currentImage.size.width + 10, 44)];
    [parentView addSubview:right0];
    [parentView addSubview:right1];
    [vc setNavigationRightView:parentView];
}

#pragma mark - 点击NavItem
- (void)touchNavItems:(UIButton *)sender {
    NSLog(@"nav %ld",(long)sender.tag);
}

#pragma mark - lazy
- (MPMinePageView *)mineView {
    if (!_mineView) {
        _mineView = [[MPMinePageView alloc] init];
    }
    return _mineView;
}

@end
