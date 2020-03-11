//
//  MPMainViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMainViewController.h"
#import "MPMainViewModel.h"
#import "Reachability.h"

@interface MPMainViewController ()

/** mainVM  */
@property (nonatomic,strong) MPMainViewModel *mainVM;
/** 网络监测 */
@property (nonatomic,strong) Reachability *netObserver;

@end

@implementation MPMainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self startNetObserver];
        [self addNotification];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.mainVM loadTabBarController:self];
    [self.mainVM showAdView:self];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark - 通知
- (void)netStatusChange:(NSNotification *)notification {
    Reachability *currReach = [notification object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    if(status == NotReachable) {
        // 页面监测慎用
        [[NSNotificationCenter defaultCenter] postNotificationName:(NSNotificationName)NetChangeErrorNotify object:@{}];
    }
}

/*
    开始网络监测
 */
- (void)startNetObserver {
    _netObserver = [Reachability reachabilityForInternetConnection];
    [_netObserver startNotifier];
}

/*
    添加通知
 */
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStatusChange:) name:kReachabilityChangedNotification object:nil];
}

#pragma mark - lazy
- (MPMainViewModel *)mainVM {
    if (!_mainVM) {
        _mainVM = [[MPMainViewModel alloc] init];
    }
    return _mainVM;
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
