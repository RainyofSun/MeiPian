//
//  MPMineCollectionView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineCollectionView.h"
#import "MPMineCollectionSliderBarView.h"
#import "MPMineCollectionArticleView.h"
#import "MPMineCollectionTopicView.h"
#import "MPMineCollectionVideoView.h"

@interface MPMineCollectionView ()<UIScrollViewDelegate>

/** mainScrollView */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/** sliderBarView */
@property (nonatomic,strong) MPMineCollectionSliderBarView *sliderBarView;
/** sliderBarSelectedIndex */
@property (nonatomic,assign) NSInteger sliderBarSelectedIndex;
/** articleView */
@property (nonatomic,strong) MPMineCollectionArticleView *articleView;
/** topicView */
@property (nonatomic,strong) MPMineCollectionTopicView *topicView;
/** videoView */
@property (nonatomic,strong) MPMineCollectionVideoView *videoView;

@end

@implementation MPMineCollectionView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.sliderBarView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.sliderBarView autoSetDimension:ALDimensionHeight toSize:50];
    [self.mainScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.mainScrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.sliderBarView];
    self.articleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - pblic methods
- (MPBaseTableView *)mineCollectionSubTabView {
    switch (self.sliderBarSelectedIndex) {
        case 0:
            return self.articleView.articleListView;
        case 1:
            return self.topicView.topicListView;
        case 2:
            return self.videoView.videoListView;
        default:
            return nil;
    }
}

#pragma mark - 消息透传
- (void)resetCollectionScrollViewContentOffset:(NSNumber *)senderTag {
    self.sliderBarSelectedIndex = senderTag.integerValue;
    switch (senderTag.integerValue) {
        case 0:
            break;
        case 1:
            if (!_topicView) {
                [self.mainScrollView addSubview:self.topicView];
                self.topicView.frame = CGRectMake(ScreenWidth * senderTag.integerValue, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
            }
            break;
        case 2:
            if (!_videoView) {
                [self.mainScrollView addSubview:self.videoView];
                self.videoView.frame = CGRectMake(ScreenWidth * senderTag.integerValue, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
            }
        default:
            break;
    }
    [self.mainScrollView setContentOffset:CGPointMake(ScreenWidth * self.sliderBarSelectedIndex, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

/**
*  滚动完毕就会调用（如果不是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
*/
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    FLOG(@"不是人为拖拽scrollView导致滚动完毕");
}

/**
 *  滚动完毕就会调用（如果是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    FLOG(@"人为拖拽scrollView导致滚动完毕");
}

#pragma mark - private methods
- (void)setupUI {
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.mainScrollView = [[UIScrollView alloc] init];
//    self.mainScrollView.backgroundColor = RGB(242, 244, 249);
    self.mainScrollView.backgroundColor = [UIColor redColor];
    self.mainScrollView.delegate = self;
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.scrollEnabled = NO;
    [self addSubview:self.mainScrollView];
    [self addSubview:self.sliderBarView];
    [self.mainScrollView addSubview:self.articleView];
    self.sliderBarSelectedIndex = 0;
}

#pragma mark - lazy
- (MPMineCollectionSliderBarView *)sliderBarView {
    if (!_sliderBarView) {
        _sliderBarView = [[MPMineCollectionSliderBarView alloc] init];
    }
    return _sliderBarView;
}

- (MPMineCollectionArticleView *)articleView {
    if (!_articleView) {
        _articleView = [[MPMineCollectionArticleView alloc] init];
    }
    return _articleView;
}

- (MPMineCollectionTopicView *)topicView {
    if (!_topicView) {
        _topicView = [[MPMineCollectionTopicView alloc] init];
    }
    return _topicView;
}

- (MPMineCollectionVideoView *)videoView {
    if (!_videoView) {
        _videoView = [[MPMineCollectionVideoView alloc] init];
    }
    return _videoView;
}

@end
