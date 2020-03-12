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

@interface MPTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation MPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setViewController];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (IS_PAD) {
        CGRect frame = self.tabBar.frame;
        frame.size.height = 90;
        frame.origin.y = self.view.frame.size.height - frame.size.height;
        self.tabBar.frame = frame;
        self.tabBar.barStyle = UIBarStyleBlack;
    }
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UIViewController*topVC = [(UINavigationController*)viewController topViewController];
        if (topVC && [topVC isKindOfClass:[MPBaseViewController class]]) {
            [MPModulesMsgSend sendCumtomMethodMsg:topVC methodName:@selector(reloadPageData)];
        }
    }
}

- (void)setupUI {
    UIColor *tabBarBgColor = [UIColor whiteColor];
    [[UITabBar appearance] setBarTintColor:tabBarBgColor];
    [UITabBar appearance].translucent = NO;
    self.delegate = self;
    [self setupTabBarColor];
}

- (void)setupTabBarColor {
    // 未选中状态的标题颜色
    CGFloat fontSize = 13;
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) {
        fontSize = 18;
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName:MAIN_GRAY_COLOR} forState:UIControlStateNormal];
    // 选中状态的标题颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
}

- (void)setViewController {
    NSArray *controllers    = @[@"MPHomePageViewController",];
    NSArray *titles         = @[@"首页",];
    for (int i = 0; i < titles.count; i++) {
        [self setupViewControllerWithControllerString:controllers[i] title:titles[i] image:@"" andSelectedImage:@""];
    }
}

/**
 *  初始化一个子控制器
 *
 *  @param controller           需要初始化的子控制器
 *  @param title                标题
 *  @param image                图标
 *  @param selectedImage        选中的图标
 */
-(void)setupViewControllerWithControllerString:(NSString *)controller title:(NSString *)title image:(NSString *)image andSelectedImage:(NSString *)selectedImage{
    /**改变tabbarItem的padding*/
    //    UIEdgeInsets insets = UIEdgeInsetsMake(6, 0, -6, 0);
    Class class = NSClassFromString(controller);
    UIViewController* viewCon = [[class alloc]init];
    [viewCon setNavHiden:YES];
    MPNavigationViewController* nav = [[MPNavigationViewController alloc] initWithRootViewController:viewCon];
    if (title) {
        viewCon.navigationItem.title = title;
        viewCon.tabBarItem.title = title;
    }
    if (image.length) {
        viewCon.tabBarItem.image            = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //    viewCon.tabBarItem.imageInsets = UIEdgeInsetsMake(-30, 0, 30, 0);
        viewCon.tabBarItem.selectedImage    = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    NSMutableArray* array = [NSMutableArray arrayWithArray:self.viewControllers];
    //    viewCon.tabBarItem.imageInsets = insets;
    [array addObject:nav];
    self.viewControllers = array;
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
