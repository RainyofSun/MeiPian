//
//  MPMinePageViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMinePageViewController.h"
#import "MPMinePageViewModel.h"

@interface MPMinePageViewController ()

/** mineVM */
@property (nonatomic,strong) MPMinePageViewModel *mineVM;

@end

@implementation MPMinePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.mineVM loadMinePageMainView:self];
}

#pragma mark - 消息透传
- (void)reloadPageData {
    NSLog(@"刷新JJ请求");
}

#pragma mark - lazy
- (MPMinePageViewModel *)mineVM {
    if (!_mineVM) {
        _mineVM = [[MPMinePageViewModel alloc] init];
    }
    return _mineVM;
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
