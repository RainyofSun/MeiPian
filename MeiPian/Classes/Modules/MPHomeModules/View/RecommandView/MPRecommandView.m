//
//  MPRecommandView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommandView.h"
#import "MPPageControlSliderBar.h"
#import "MPRecommandAllView.h"
#import "MPJingXuanView.h"
#import "MPSheYingView.h"

@interface MPRecommandView ()<UIScrollViewDelegate>

/** topBar */
@property (nonatomic,strong) MPPageControlSliderBar *topBar;
/** titleArray */
@property (nonatomic,strong) NSArray <NSString *>*titleArray;
/**mainScrollView */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/** allView */
@property (nonatomic,strong) MPRecommandAllView *allView;
/** JXView */
@property (nonatomic,strong) MPJingXuanView *JXView;
/** SYView */
@property (nonatomic,strong) MPSheYingView *SYView;

@end

@implementation MPRecommandView

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mainScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.mainScrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topBar];
    
    self.allView.frame = CGRectMake(0, 8, CGRectGetWidth(self.bounds), (CGRectGetHeight(self.bounds) - CGRectGetHeight(self.topBar.bounds)));
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - 消息透传
- (void)switchTopSliderBarItem:(NSNumber *)senderTag {
    switch (senderTag.integerValue) {
        case 0:
            [self.mainScrollView setContentOffset:CGPointZero animated:YES];
            break;
        case 1:
            [self.mainScrollView addSubview:self.JXView];
            self.JXView.frame = CGRectMake(ScreenWidth * senderTag.integerValue, 0, ScreenWidth, CGRectGetHeight(self.allView.bounds));
            [self.mainScrollView setContentOffset:CGPointMake(ScreenWidth * senderTag.integerValue, 0) animated:YES];
            break;
        case 2:
            [self.mainScrollView addSubview:self.SYView];
            self.SYView.frame = CGRectMake(ScreenWidth * senderTag.integerValue, 0, ScreenWidth, CGRectGetHeight(self.allView.bounds));
            [self.mainScrollView setContentOffset:CGPointMake(ScreenWidth * senderTag.integerValue, 0) animated:YES];
            break;
        default:
            break;
    }
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
- (void)setDefaultData {
    self.titleArray = @[@"全部",@"精选",@"摄影",@"情感",@"文学",@"旅行"];
}

- (void)setupUI {
    
    self.mainScrollView = [[UIScrollView alloc] init];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.mainScrollView.delegate = self;
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth * self.titleArray.count, 0);
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    self.mainScrollView.scrollEnabled = NO;
    [self addSubview:self.mainScrollView];
    
    self.backgroundColor = MAIN_LIGHT_GRAY_COLOR;
    [self addSubview:self.topBar];
    [self.topBar loadSliderBarTitleSource:self.titleArray];
    [self.mainScrollView addSubview:self.allView];
}

#pragma mark - lazy
- (MPPageControlSliderBar *)topBar {
    if (!_topBar) {
        _topBar = [[MPPageControlSliderBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    }
    return _topBar;
}

- (MPRecommandAllView *)allView {
    if (!_allView) {
        _allView = [[MPRecommandAllView alloc] init];
    }
    return _allView;
}

- (MPJingXuanView *)JXView {
    if (!_JXView) {
        _JXView = [[MPJingXuanView alloc] init];
    }
    return _JXView;
}

- (MPSheYingView *)SYView {
    if (!_SYView) {
        _SYView = [[MPSheYingView alloc] init];
    }
    return _SYView;
}

@end
