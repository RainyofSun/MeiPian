//
//  MPMinePageView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMinePageView.h"
#import "MPMineViewModel.h"
#import "MPMineInfoView.h"
#import "MPMineArticleScrollView.h"
#import "MPDynamicItem.h"
#import "MPDolphinRefreshHeader.h"

/*f(x, d, c) = (x * d * c) / (d + c * x)
 where,
 x – distance from the edge
 c – constant (UIScrollView uses 0.55)
 d – dimension, either width or height*/

static CGFloat rubberBandDistance(CGFloat offset, CGFloat dimension) {
    
    const CGFloat constant = 0.55f;
    CGFloat result = (constant * fabs(offset) * dimension) / (dimension + constant * fabs(offset));
    // The algorithm expects a positive offset, so we have to negate the result if the offset was negative.
    return offset < 0.0f ? -result : result;
}

@interface MPMinePageView ()<UIGestureRecognizerDelegate,UIDynamicAnimatorDelegate>

/**mainScrollView */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/** mineVM */
@property (nonatomic,strong) MPMineViewModel *mineVM;
/** infoView */
@property (nonatomic,strong) MPMineInfoView *infoView;
/** articleView */
@property (nonatomic,strong) MPMineArticleScrollView *articleView;
/** mineSource */
@property (nonatomic,strong) NSArray <MPMineConfigModel *>*mineSource;
/** sliderbarSelectedIndex */
@property (nonatomic,assign) NSInteger sliderbarSelectedIndex;
/** isBegingRefresh */
@property (nonatomic,assign) CGFloat isBegingRefresh;

/** panGes */
@property (nonatomic,strong) UIPanGestureRecognizer *panGes;

/** currentScrollY */
@property (nonatomic,assign) CGFloat currentScrollY;
/** isVertical */
@property (nonatomic,assign) BOOL isVertical;

// 弹性&惯性动画
/** dynamicItem */
@property (nonatomic,strong) MPDynamicItem *dynamicItem;
/** animator */
@property (nonatomic,strong) UIDynamicAnimator *animator;
/** decelerationBehavior */
@property (nonatomic,weak) UIDynamicItemBehavior *decelerationBehavior;
/** springBehavior */
@property (nonatomic,weak) UIAttachmentBehavior *springBehavior;

@end

@implementation MPMinePageView

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
        [self setupUI];
        [self addHeightObserver];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mainScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    self.infoView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), self.infoView.infoViewH);
    self.articleView.frame = CGRectMake(0, self.infoView.infoViewH, CGRectGetWidth(self.bounds), self.articleView.artcileViewH);
}

- (void)dealloc {
    [self.animator removeAllBehaviors];
    [self removeHeightObserver];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - 消息透传
// 切换sliderBar
- (void)switchSliderBar:(NSNumber *)senderTag {
    self.sliderbarSelectedIndex = senderTag.integerValue;
    [self.infoView switchSliderbarSelectedItem:senderTag];
}

// 重新调整偏移量
- (void)resetScrollViewContentOffset:(NSNumber *)senderTag {
    self.sliderbarSelectedIndex = senderTag.integerValue;
    [self.articleView resetSubScrollViewContentOffSet:senderTag];
}

// 下拉刷新
- (void)loadMineData {
    [self requestMineInfo];
}

#pragma mark - KVC
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 这里放异步执行任务代码
        NSLog(@"重设contentSize SubViewFrame %f",self.articleView.artcileViewH);
        self.mainScrollView.contentSize = CGSizeMake(0, self.articleView.artcileViewH + self.infoView.infoViewH);
    });
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.currentScrollY = self.mainScrollView.contentOffset.y;
            CGFloat currentY    = [recognizer translationInView:self].y;
            CGFloat currentX    = [recognizer translationInView:self].x;
            if (currentY == 0.0) {
                self.isVertical = NO;
            } else {
                if (fabs(currentX)/currentY >= 5.0) {
                    self.isVertical = NO;
                } else {
                    self.isVertical = YES;
                }
            }
            [self.animator removeAllBehaviors];
            break;
        case UIGestureRecognizerStateChanged:
        {
            //locationInView:获取到的是手指点击屏幕实时的坐标点；
            //translationInView：获取到的是手指移动后，在相对坐标中的偏移量
            if (self.isVertical) {
                // 往上滑为负数,往下滑是正数
                CGFloat currentY = [recognizer translationInView:self].y;
                [self controlScrollForVertical:currentY AndState:UIGestureRecognizerStateChanged];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (self.isVertical) {
                self.dynamicItem.center = self.bounds.origin;
                // velocity 是在手指结束的时候获取的竖直方向的手势速度
                CGPoint velocity = [recognizer velocityInView:self];
                UIDynamicItemBehavior *inertialBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.dynamicItem]];
                [inertialBehavior addLinearVelocity:CGPointMake(0, velocity.y) forItem:self.dynamicItem];
                // 尝试取2.0比较像系统的效果
                inertialBehavior.resistance = 2.0;
                __block CGPoint lastCenter = CGPointZero;
                WeakSelf;
                inertialBehavior.action = ^{
                    if (weakSelf.isVertical) {
                        // 得到每次移动的距离
                        CGFloat currentY = weakSelf.dynamicItem.center.y - lastCenter.y;
                        [weakSelf controlScrollForVertical:currentY AndState:UIGestureRecognizerStateChanged];
                    }
                    lastCenter = weakSelf.dynamicItem.center;
                };
                [self.animator addBehavior:inertialBehavior];
                self.decelerationBehavior = inertialBehavior;
            }
        }
            break;
        default:
            break;
    }
    // 保证每次只是移动的距离,不是从头一直移动的距离
    [recognizer setTranslation:CGPointZero inView:self];
}

#pragma mark - UIDynamicAnimatorDelegate
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    self.isBegingRefresh = NO;
}

#pragma mark - private methods
- (void)setDefaultData {
    self.sliderbarSelectedIndex = 0;
    self.isBegingRefresh = NO;
}

- (void)setupUI {
    self.mainScrollView = [[UIScrollView alloc] init];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.mainScrollView.contentSize = CGSizeMake(0, self.articleView.artcileViewH + self.infoView.infoViewH);
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    self.mainScrollView.scrollEnabled = NO;
    self.mainScrollView.delegate = self;
    [self addSubview:self.mainScrollView];
    
    [self.mainScrollView addSubview:self.infoView];
    [self.mainScrollView addSubview:self.articleView];
    
    self.panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    self.panGes.delegate = self;
    [self addGestureRecognizer:self.panGes];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    self.animator.delegate = self;
    self.dynamicItem = [[MPDynamicItem alloc] init];
    [self setRefreshHeader];
}

- (void)addHeightObserver {
    [self.articleView MP_AddLEDObserver:self forKeyPath:@"artcileViewH" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeHeightObserver {
    [self.articleView MP_RemoveObserver:self forKeyPath:@"artcileViewH"];
}

- (void)setRefreshHeader {
    self.mainScrollView.mj_header = [MPDolphinRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMineData)];
    // 马上进入刷新状态
    [self.mainScrollView.mj_header beginRefreshing];
}

//控制上下滚动的方法
- (void)controlScrollForVertical:(CGFloat)detal AndState:(UIGestureRecognizerState)state {
    // 判断是MainScrollView滚动还是子ScrollView滚动,detal为手指移动的距离
    MPBaseTableView *subView = [self.articleView getArticleCellTableView];
    if (self.mainScrollView.contentOffset.y >= self.infoView.TopDistance) {
        CGFloat offsetY = subView.contentOffset.y - detal;
        if (offsetY < 0) {
            // 当子ScrollView的contentOffSet小于0之后就b不再移动子ScrollView,而要移动mainScrollView
            offsetY = 0;
            self.mainScrollView.contentOffset = CGPointMake(0, self.mainScrollView.contentOffset.y - detal);
        } else if (offsetY > (subView.contentSize.height - subView.frame.size.height)) {
            // 当子ScrollView的contenOffset大于tableView的可移动距离时
            offsetY = subView.contentOffset.y - rubberBandDistance(detal, CGRectGetHeight(self.bounds));
        }
        NSLog(@"subTableView %f",offsetY);
        subView.contentOffset = CGPointMake(0, offsetY);
    } else {
        CGFloat mainOffsetY = self.mainScrollView.contentOffset.y - detal;
        if (mainOffsetY < 0) {
            // 滚动到顶部之后继续往上滚动需要乘以一个小于1的系数
            mainOffsetY = self.mainScrollView.contentOffset.y - rubberBandDistance(detal, CGRectGetHeight(self.bounds));
            if (mainOffsetY <= -30) {
                // 触发下拉刷新
                [self triggerMineInfoRefresh];
            }
        } else if (mainOffsetY > self.infoView.TopDistance) {
            mainOffsetY = self.infoView.TopDistance;
        }
        NSLog(@"MainScrollView %f",mainOffsetY);
        self.mainScrollView.contentOffset = CGPointMake(0, mainOffsetY);
        [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(showOrHideNavTitleView:) params:[NSNumber numberWithFloat:mainOffsetY]];
    }
    
    BOOL outsideFrame = [self outsideFrame];
    if (outsideFrame && (self.decelerationBehavior && !self.springBehavior)) {
        CGPoint target = CGPointZero;
        BOOL isMain = NO;
        if (self.mainScrollView.contentOffset.y < 0) {
            self.dynamicItem.center = self.mainScrollView.contentOffset;
            target = CGPointZero;
            isMain = YES;
        } else if (subView.contentOffset.y > (subView.contentSize.height - subView.frame.size.height)) {
            self.dynamicItem.center = subView.contentOffset;
            target.x = subView.contentOffset.x;
            target.y = subView.contentSize.height > subView.frame.size.height ? subView.contentSize.height - subView.frame.size.height : 0;
            isMain = NO;
        } else if (subView.contentOffset.y < 0) {
            self.dynamicItem.center = subView.contentOffset;
            target = CGPointZero;
            isMain = NO;
        }
        [self.animator removeBehavior:self.decelerationBehavior];
        WeakSelf;
        UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.dynamicItem attachedToAnchor:target];
        springBehavior.length = 0;
        springBehavior.damping = 1;
        springBehavior.frequency = 2;
        springBehavior.action = ^{
            if (isMain) {
                weakSelf.mainScrollView.contentOffset = weakSelf.dynamicItem.center;
                if (weakSelf.mainScrollView.contentOffset.y == 0) {
                    subView.contentOffset = CGPointZero;
                }
            } else {
                subView.contentOffset = weakSelf.dynamicItem.center;
                if (subView.mj_footer.refreshing) {
                    subView.contentOffset = CGPointMake(subView.contentOffset.x, subView.contentOffset.y + 44);
                } else if (subView.mj_header.refreshing) {
                    subView.contentOffset = CGPointMake(subView.contentOffset.x, subView.contentOffset.y + 44);
                }
            }
        };
        [self.animator addBehavior:springBehavior];
        self.springBehavior = springBehavior;
    }
}

// 判断是否超出ViewFrame的边界
- (BOOL)outsideFrame {
    if (self.mainScrollView.contentOffset.y < 0) {
        return YES;
    }
    MPBaseTableView *subView = [self.articleView getArticleCellTableView];
    if (subView.contentOffset.y < 0) {
        return YES;
    }
    if (subView.contentSize.height > subView.frame.size.height) {
        if (subView.contentOffset.y > (subView.contentSize.height - subView.frame.size.height)) {
            return YES;
        } else {
            return NO;
        }
    } else {
        if (subView.contentOffset.y > 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

// 下拉触发刷新
- (void)triggerMineInfoRefresh {
    if (self.isBegingRefresh) {
        NSLog(@"拦截无效刷新");
        return;
    }
    self.isBegingRefresh = YES;
    [self.mainScrollView.mj_header beginRefreshing];
}

- (void)requestMineInfo {
    WeakSelf;
    [self.mineVM MPMineInfoRequest:^(id  _Nonnull returnValue) {
        weakSelf.mineSource = (NSArray <MPMineConfigModel *>*)returnValue;
        [weakSelf.infoView loadMineInfoSource:weakSelf.mineSource.firstObject.infoModel];
        [weakSelf.infoView loadSliderBarSource:weakSelf.mineSource.firstObject.sliderTitleSource];
        [weakSelf.articleView loadMineArticleSource:weakSelf.mineSource.lastObject.articleModel];
        [weakSelf.articleView loadMineArticleHeightSource:weakSelf.mineSource.lastObject.cellHeightSource];
        [weakSelf.mainScrollView.mj_header endRefreshing];
        [MPModulesMsgSend sendCumtomMethodMsg:[weakSelf nearsetViewController] methodName:@selector(reloadNavTitleView:) params:@{
            @"head_img_url":weakSelf.mineSource.firstObject.infoModel.head_img_url,
            @"nickname":weakSelf.mineSource.firstObject.infoModel.nickname
        }];
    }];
}

#pragma mark - lazy
- (MPMineViewModel *)mineVM {
    if (!_mineVM) {
        _mineVM = [[MPMineViewModel alloc] init];
    }
    return _mineVM;
}

- (MPMineInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[[NSBundle mainBundle] loadNibNamed:@"MPMineInfoView" owner:nil options:nil] firstObject];
    }
    return _infoView;
}

- (MPMineArticleScrollView *)articleView {
    if (!_articleView) {
        _articleView = [[MPMineArticleScrollView alloc] init];
    }
    return _articleView;
}

@end
