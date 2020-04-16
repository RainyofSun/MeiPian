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
    [vc.view addSubview:self.mineView];
    [self.mineView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark - lazy
- (MPMinePageView *)mineView {
    if (!_mineView) {
        _mineView = [[MPMinePageView alloc] init];
    }
    return _mineView;
}

@end
