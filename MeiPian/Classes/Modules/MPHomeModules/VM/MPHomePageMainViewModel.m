//
//  MPHomePageMainViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPHomePageMainViewModel.h"
#import "XLPageViewController.h"
#import "MPAttentionView.h"
#import "MPRecommandView.h"
#import "MPTopicView.h"
#import "MPPhotographAlbumView.h"
#import "MPHomePageSubViewController.h"
#import "MPHomePageSliderBarTitleCollectionViewCell.h"
#import "MPCustomHomePageNavView.h"

static NSString *topSliderBarIndifier = @"MPHomePageSliderBarTitle";

@interface MPHomePageMainViewModel ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

/** pageControlView */
@property (nonatomic,strong) XLPageViewController *pageControlView;
/** selectedItemIndex */
@property (nonatomic,assign) NSInteger selectedItemIndex;
/** titleArray */
@property (nonatomic,strong) NSArray <NSString *>*titleArray;
/** itemViewArray */
@property (nonatomic,strong) NSMutableArray <UIView *>*itemViewArray;

@end

@implementation MPHomePageMainViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载顶部页面控制
- (void)loadTopPageControl:(UIViewController *)vc {
    [vc addChildViewController:self.pageControlView];
    [vc.view addSubview:self.pageControlView.view];
    [self.pageControlView.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.pageControlView.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:vc.view withOffset:kStatusBarHeight];
    self.pageControlView.delegate = self;
    self.pageControlView.dataSource = self;
    [self.pageControlView registerClass:[MPHomePageSliderBarTitleCollectionViewCell class] forTitleViewCellWithReuseIdentifier:topSliderBarIndifier];
    self.pageControlView.selectedIndex = 1;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"122" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(touchSlideBarLeftItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(touchSlideBarRightItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.pageControlView.leftButton = leftBtn;
    self.pageControlView.rightButton = rightBtn;
}

#pragma mark - XLPageViewControllerDelegate
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    MPHomePageSubViewController *subVC = [[MPHomePageSubViewController alloc] initWithNibName:@"MPHomePageSubViewController" bundle:nil];
    return subVC;
}

- (NSString *)pageViewController:(XLPageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titleArray.count;
}

- (XLPageTitleCell *)pageViewController:(XLPageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index {
    MPHomePageSliderBarTitleCollectionViewCell *cell = [pageViewController dequeueReusableTitleViewCellWithIdentifier:topSliderBarIndifier forIndex:index];
    return cell;
}

- (void)pageViewController:(XLPageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    FLOG(@"切换到了 %@ vc = %@",self.titleArray[index],[pageViewController cellVCForRowAtIndex:index]);
}

#pragma mark - 点击NavBar
- (void)touchSlideBarLeftItem:(UIButton *)sender {
    NSLog(@"跳转日历签到");
}

- (void)touchSlideBarRightItem:(UIButton *)sender {
    NSLog(@"搜索文字");
}

#pragma mark - private methods
- (void)setDefaultData {
    self.selectedItemIndex = 1;
    self.titleArray = @[@"关注",@"推荐",@"话题",@"影集"];
}

- (XLPageViewControllerConfig *)pageControlConfig {
    XLPageViewControllerConfig *config = [XLPageViewControllerConfig defaultConfig];
    //标题按钮边缘距离
    config.btnDistanceToEdge = 10;
    //标题间距
    config.titleSpace = 20;
    //标题高度
    config.titleViewHeight = 45;
    //标题选中颜色
    config.titleSelectedColor = RGB(34, 34, 34);
    //标题选中字体
    config.titleSelectedFont = [UIFont boldSystemFontOfSize:17];
    //标题正常颜色
    config.titleNormalColor = RGBA(0, 0, 0, 0.8);
    //标题正常字体
    config.titleNormalFont = [UIFont systemFontOfSize:17];
    //阴影颜色
    config.shadowLineColor = RGB(48, 130, 255);
    //阴影宽度
    config.shadowLineWidth = 27;
    //阴影距离边缘位置
    config.shadowLineDistanceToEdge = 5;
    //分割线颜色
    config.separatorLineColor = RGB(238, 238, 238);
    //标题位置
    config.titleViewAlignment = XLPageTitleViewAlignmentCenter;
    
    return config;
}

#pragma mark - lazy
- (XLPageViewController *)pageControlView {
    if (!_pageControlView) {
        _pageControlView = [[XLPageViewController alloc] initWithConfig:[self pageControlConfig]];
    }
    return _pageControlView;
}

@end
