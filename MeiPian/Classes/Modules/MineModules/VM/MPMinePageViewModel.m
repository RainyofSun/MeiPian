//
//  MPMinePageViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMinePageViewModel.h"
#import "MPMinePageView.h"
#import "MPMineNavTitleView.h"

@interface MPMinePageViewModel ()

/** mineView */
@property (nonatomic,strong) MPMinePageView *mineView;
/** titleView */
@property (nonatomic,strong) MPMineNavTitleView *titleView;
/** printBtn */
@property (nonatomic,strong) UIButton *printBtn;

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
    
    self.printBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.printBtn setImage:[UIImage imageNamed:@"print_icon_large_0711"] forState:UIControlStateNormal];
    [self.printBtn setImage:[UIImage imageNamed:@"print_icon_small_0711"] forState:UIControlStateSelected];
    [self.printBtn addTarget:self action:@selector(touchNavItems:) forControlEvents:UIControlEventTouchUpInside];
    self.printBtn.frame = CGRectMake(0, 7, self.printBtn.currentImage.size.width, self.printBtn.currentImage.size.height);
    self.printBtn.tag = 1;
    
    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [right1 setImage:[UIImage imageNamed:@"nav_icon_rightslip"] forState:UIControlStateNormal];
    [right1 addTarget:self action:@selector(touchNavItems:) forControlEvents:UIControlEventTouchUpInside];
    right1.frame = CGRectMake(self.printBtn.currentImage.size.width + 10, 0, right1.currentImage.size.width, 44);
    right1.tag = 2;
    
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.printBtn.currentImage.size.width + right1.currentImage.size.width + 10, 44)];
    [parentView addSubview:self.printBtn];
    [parentView addSubview:right1];
    [vc setNavigationRightView:parentView];
}

// 创建NavTitle
- (void)setMineNavTitleView:(UIViewController *)vc withUserInfo:(NSDictionary *)userInfo {
    self.titleView.frame = CGRectMake(0, 0, 90, 44);
    [vc setNavigationTitleView:self.titleView];
    [self.titleView reloadUserHeadImg:[userInfo objectForKey:@"head_img_url"] withUserName:[userInfo objectForKey:@"nickname"]];
}

// 显示/隐藏NavTitleView
- (void)controlNavTitleViewShowOrHide:(NSNumber *)contentOffsetY {
    if (contentOffsetY.floatValue < 0) {
        return;
    }
    CGFloat alpha = contentOffsetY.floatValue/100;
    alpha = (alpha > 1) ? 1 : alpha;
    self.printBtn.selected = (alpha >= 0.8);
    [self printBtnAnimation:self.printBtn.selected];
    [self.titleView showNavTitleView:alpha];
}

#pragma mark - 点击NavItem
- (void)touchNavItems:(UIButton *)sender {
    NSLog(@"nav %ld",(long)sender.tag);
}

#pragma mark - private methods
- (void)printBtnAnimation:(BOOL)isLarge {
    CGFloat left = isLarge ? 55 : 0;
    [UIView animateWithDuration:0.3 animations:^{
       self.printBtn.frame = CGRectMake(left, 7, self.printBtn.currentImage.size.width, self.printBtn.currentImage.size.height);
    }];
}

#pragma mark - lazy
- (MPMinePageView *)mineView {
    if (!_mineView) {
        _mineView = [[MPMinePageView alloc] init];
    }
    return _mineView;
}

- (MPMineNavTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[MPMineNavTitleView alloc] init];
    }
    return _titleView;
}

@end
