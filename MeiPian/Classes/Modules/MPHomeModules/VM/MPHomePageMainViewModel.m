//
//  MPHomePageMainViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPHomePageMainViewModel.h"
#import "MPHomePageControlView.h"
#import "MPAttentionView.h"
#import "MPRecommandView.h"
#import "MPTopicView.h"
#import "MPPhotographAlbumView.h"

@interface MPHomePageMainViewModel ()

/** pageControlView */
@property (nonatomic,strong) MPHomePageControlView *pageControlView;
/** attentioonView */
@property (nonatomic,strong) MPAttentionView *attontionView;
/** recommondView */
@property (nonatomic,strong) MPRecommandView *recommondView;
/** topicView */
@property (nonatomic,strong) MPTopicView *topicView;
/** albumView */
@property (nonatomic,strong) MPPhotographAlbumView *albumView;
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
    [vc.view addSubview:self.pageControlView];
    [self.pageControlView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.pageControlView loadTopBarTitleSources:self.titleArray];
    [self.pageControlView loadScrollViewContentViews:self.itemViewArray];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.selectedItemIndex = 1;
    self.titleArray = @[@"关注",@"推荐",@"话题",@"影集"];
    self.itemViewArray = [NSMutableArray arrayWithObjects:self.attontionView,self.recommondView,self.topicView,self.albumView, nil];
}

#pragma mark - lazy
- (MPHomePageControlView *)pageControlView {
    if (!_pageControlView) {
        _pageControlView = [[MPHomePageControlView alloc] init];
    }
    return _pageControlView;
}

- (MPAttentionView *)attontionView {
    if (!_attontionView) {
        _attontionView = [[MPAttentionView alloc] init];
    }
    return _attontionView;
}

- (MPRecommandView *)recommondView {
    if (!_recommondView) {
        _recommondView = [[MPRecommandView alloc] init];
    }
    return _recommondView;
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

@end
