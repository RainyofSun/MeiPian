//
//  MPHomePageControlView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPHomePageControlView.h"
#import "MPPageControlSliderBar.h"

@interface MPHomePageControlView ()<UIScrollViewDelegate>

/** mainScrollView */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/** sliderBar */
@property (nonatomic,strong) MPPageControlSliderBar *sliderBar;
/** contentViews */
@property (nonatomic,strong) NSArray <UIView *>*contentViews;
/** lastContentOffset */
@property (nonatomic,assign) CGFloat lastContentOffset;

@end

@implementation MPHomePageControlView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mainScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    WeakSelf;
    [self.contentViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       obj.frame = CGRectMake(ScreenWidth * idx, 0, CGRectGetWidth(weakSelf.bounds), CGRectGetHeight(weakSelf.bounds));
    }];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadScrollViewContentViews:(NSArray<UIView *> *)views {
    self.contentViews = views;
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth * self.contentViews.count, 0);
    for (NSInteger i = 0; i < views.count; i ++) {
        [self.mainScrollView addSubview:views[i]];
    }
}

- (void)loadTopBarTitleSources:(NSArray<NSString *> *)titleSource {
    [self.sliderBar loadSliderBarTitleSource:titleSource];
}

#pragma mark - 消息透传
- (void)switchTopSliderBarItem:(NSNumber *)senderTag {
    [self.mainScrollView setContentOffset:CGPointMake(ScreenWidth * senderTag.integerValue, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffset = scrollView.contentOffset.x;
    
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
    CGFloat x = scrollView.contentOffset.x / ScreenWidth;
    FLOG(@"人为拖拽scrollView导致滚动完毕 %f",x);
    [self.sliderBar lineAnimation:x];
//    [YZModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(swicthDistributePageView:) params:[NSNumber numberWithFloat:x]];
}

#pragma mark - private methods
- (void)setupUI {
    self.mainScrollView = [[UIScrollView alloc] init];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.mainScrollView.delegate = self;
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth * 4, 0);
    
    [self addSubview:self.mainScrollView];
    [self addSubview:self.sliderBar];
}

#pragma mark - lazy
- (MPPageControlSliderBar *)sliderBar {
    if (!_sliderBar) {
        _sliderBar = [[MPPageControlSliderBar alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, ScreenWidth, 40)];
    }
    return _sliderBar;
}

@end
