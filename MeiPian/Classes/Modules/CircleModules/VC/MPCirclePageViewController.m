//
//  MPCirclePageViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCirclePageViewController.h"
#import "MPCirclePageViewModel.h"

@interface MPCirclePageViewController ()

/** circleVM */
@property (nonatomic,strong) MPCirclePageViewModel *circleVM;

@end

@implementation MPCirclePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.circleVM loadMainCirclePageView:self];
    [self.circleVM setupCircleNavItems:self];
}

#pragma mark - 消息透传
- (void)reloadPageData {
    NSLog(@"刷新JJ请求");
}

- (void)selectedRecommandArticle:(NSNumber *)recommandArticleTag {
    NSLog(@"点击推荐文章 %@",recommandArticleTag);
}

#pragma mark - lazy
- (MPCirclePageViewModel *)circleVM {
    if (!_circleVM) {
        _circleVM = [[MPCirclePageViewModel alloc] init];
    }
    return _circleVM;
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
