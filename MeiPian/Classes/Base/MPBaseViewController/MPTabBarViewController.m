//
//  MPTabBarViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPTabBarViewController.h"
#import "MPNavigationViewController.h"
#import "MPHomePageViewController.h"
#import "MPCirclePageViewController.h"
#import "MPMessagePageViewController.h"
#import "MPMinePageViewController.h"
#import "MPBaseCustomTabBar.h"

@interface MPTabBarViewController ()<MPCustomTabBarDelegate>

/** customBar */
@property (nonatomic,strong) MPBaseCustomTabBar *customBar;
/** emptyIndex */
@property (nonatomic,assign) NSInteger emptyIndex;

@end

@implementation MPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setViewController];
}

#pragma mark - MPCustomTabBarDelegate
- (BOOL)shouldSelectedViewController:(NSInteger)viewControllerIndex {
    if (![MPUserStatusGlobalModel UserGlobalModel].isLogin) {
        if (viewControllerIndex == 3 || viewControllerIndex == 4) {
            [self presentNavVC:@"MPWeiChatLoginViewController"];
            return NO;
        }
    }
    return YES;
}

- (void)didSelectedViewController:(NSInteger)viewControllerIndex {
    if (viewControllerIndex == self.emptyIndex) {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentVC:@"MPCorpusViewController"];
        return;
    }
    viewControllerIndex = viewControllerIndex > self.emptyIndex ? (viewControllerIndex - 1) : viewControllerIndex;
    MPNavigationViewController *selectedNav = (MPNavigationViewController *)[self.childViewControllers objectAtIndex:viewControllerIndex];
    UIViewController*topVC = [selectedNav topViewController];
    if (topVC && [topVC isKindOfClass:[MPBaseViewController class]]) {
        [MPModulesMsgSend sendCumtomMethodMsg:topVC methodName:@selector(reloadPageData)];
    }
    self.selectedIndex = viewControllerIndex;
}

- (void)setViewController {
    //设置tabbar背景颜色
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor whiteColor]]];

    NSArray *controllers    = @[@"MPHomePageViewController",@"MPCirclePageViewController",@"",@"MPMessagePageViewController",@"MPMinePageViewController"];
    NSArray *titles         = @[@"首页",@"圈子",@"",@"消息",@"我的"];
    self.emptyIndex         = 2;
    self.customBar = [[MPBaseCustomTabBar alloc] initWithTitleSource:titles];
    [self.customBar setNormalItemTextColor:RGB(125, 125, 125) selectedTextColor:[UIColor blackColor]];
    self.customBar.tabBarDelegate = self;
    [self setValue:self.customBar forKey:@"tabBar"];
    for (int i = 0; i < titles.count; i++) {
        [self setupViewControllerWithControllerString:controllers[i] title:titles[i]];
    }
}

-(void)setupViewControllerWithControllerString:(NSString *)controller title:(NSString *)title {
    if (!controller.length) {
        return;
    }
    Class class = NSClassFromString(controller);
    UIViewController* viewCon = [[class alloc]init];
    [viewCon setNavHiden:YES];
    MPNavigationViewController* nav = [[MPNavigationViewController alloc] initWithRootViewController:viewCon];
    NSMutableArray* array = [NSMutableArray arrayWithArray:self.viewControllers];
    [array addObject:nav];
    self.viewControllers = array;
}

- (NSUInteger)selectedIndex {
    return self.customBar.selectedIndex;
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
