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
#import "MPCalendarBtn.h"
#import "MPHomePageConfigModel.h"
#import "MPMessageViewModel.h"
#import "MPBaseCustomTabBar.h"

static NSString *topSliderBarIndifier = @"MPHomePageSliderBarTitle";

@interface MPHomePageMainViewModel ()<XLPageViewControllerDelegate,XLPageViewControllerDataSrouce>

/** pageControlView */
@property (nonatomic,strong) XLPageViewController *pageControlView;
/** attentionView */
@property (nonatomic,strong) MPAttentionView *attentionView;
/** recommandView */
@property (nonatomic,strong) MPRecommandView *recommandView;
/** topicView */
@property (nonatomic,strong) MPTopicView *topicView;
/** albumView */
@property (nonatomic,strong) MPPhotographAlbumView *albumView;
/** selectedItemIndex */
@property (nonatomic,assign) NSInteger selectedItemIndex;
/** titleArray */
@property (nonatomic,strong) NSMutableArray <NSString *>*titleArray;
/** topBarSource */
@property (nonatomic,strong) MPHomePageConfigModel *topBarModel;
/** messageVM */
@property (nonatomic,strong) MPMessageViewModel *messageVM;

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
    self.pageControlView.selectedIndex = self.selectedItemIndex;
    
    MPCalendarBtn *leftBtn = [MPCalendarBtn buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:[self currentCalendarNum] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(touchSlideBarLeftItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(touchSlideBarRightItem:) forControlEvents:UIControlEventTouchUpInside];
    
    self.pageControlView.leftButton = leftBtn;
    self.pageControlView.rightButton = rightBtn;
    
    // 设置未读消息角标
    [self setTabBarBedgeNum:vc];
}

#pragma mark - XLPageViewControllerDelegate
- (UIViewController *)pageViewController:(XLPageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    MPHomePageSubViewController *subVC = [[MPHomePageSubViewController alloc] initWithNibName:@"MPHomePageSubViewController" bundle:nil];
    switch (index) {
        case 0:
            if (!_attentionView) {
                [subVC addHomePageSubView:self.attentionView];
            }
            break;
        case 1:
            if (!_recommandView) {
                [subVC addHomePageSubView:self.recommandView];
            }
            break;
        case 2:
            if (!_topicView) {
                [subVC addHomePageSubView:self.topicView];
            }
            break;
        case 3:
            if (!_albumView) {
                [subVC addHomePageSubView:self.albumView];
            }
            break;
        default:
            break;
    }
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
    if (!sender.selected) {
        sender.selected = !sender.selected;
    }
}

- (void)touchSlideBarRightItem:(UIButton *)sender {
    NSLog(@"搜索文字");
}

#pragma mark - private methods
- (void)setDefaultData {
    self.selectedItemIndex = 1;
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:@"TopBar" localData:^(id  _Nonnull responseObject) {
        weakSelf.topBarModel = [MPHomePageConfigModel modelWithDictionary:(NSDictionary *)responseObject];
        [weakSelf combineTopBarData:weakSelf.topBarModel];
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

- (void)combineTopBarData:(MPHomePageConfigModel *)configModel {
    self.titleArray = [NSMutableArray arrayWithCapacity:configModel.main_channel.count];
    WeakSelf;
    [configModel.main_channel enumerateObjectsUsingBlock:^(MPHomePageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.titleArray addObject:obj.tag_name];
    }];
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

// 设置tabBar未读消息角标
- (void)setTabBarBedgeNum:(UIViewController *)vc {
    WeakSelf;
    [self.messageVM MPMessageRequestInfo:^(id  _Nonnull returnValue) {
        MPBaseCustomTabBar *tabBar = (MPBaseCustomTabBar *)vc.tabBarController.tabBar;
        [tabBar setTabBarItemBedgeNum:weakSelf.messageVM.bedgeNum itemSelectedIndex:3];
    } loadType:MPLoadingType_Normal];
}

#pragma mark - lazy
- (XLPageViewController *)pageControlView {
    if (!_pageControlView) {
        _pageControlView = [[XLPageViewController alloc] initWithConfig:[self pageControlConfig]];
    }
    return _pageControlView;
}

- (MPAttentionView *)attentionView {
    if (!_attentionView) {
        _attentionView = [[MPAttentionView alloc] init];
    }
    return _attentionView;
}

- (MPRecommandView *)recommandView {
    if (!_recommandView) {
        _recommandView = [[MPRecommandView alloc] init];
    }
    return _recommandView;
}

- (MPTopicView *)topicView {
    if (!_topicView) {
        _topicView = [[MPTopicView alloc] init];
    }
    return _topicView;
}

- (MPPhotographAlbumView *)albumView {
    if (!_albumView) {
        _albumView = [[MPPhotographAlbumView alloc] init];
    }
    return _albumView;
}

- (MPMessageViewModel *)messageVM {
    if (!_messageVM) {
        _messageVM = [[MPMessageViewModel alloc] init];
    }
    return _messageVM;
}

@end
