//
//  MPHomePageViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/12.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPHomePageViewController.h"

@interface MPHomePageViewController ()

@end

@implementation MPHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 消息透传
- (void)sendHomePageRequest {
    NSLog(@"刷新网络请求");
}

- (void)reloadPageData {
    
}

- (void)showAdLink {
    NSLog(@"广告链接");
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
