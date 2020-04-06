//
//  MPSheYingView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/2.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPSheYingView.h"
#import "MPSheYingArticleView.h"
#import "MPSheYingBannerLoopView.h"
#import "MPDynamicItem.h"

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

@interface MPSheYingView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

/**mainScrollView */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/** articleView */
@property (nonatomic,strong) MPSheYingArticleView *articleView;
/** loopView */
@property (nonatomic,strong) MPSheYingBannerLoopView *loopView;
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

@implementation MPSheYingView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mainScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    self.loopView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), self.loopView.loopH);
    self.articleView.frame = CGRectMake(0, self.loopView.loopH, CGRectGetWidth(self.bounds), ScreenHeight);
}

- (void)dealloc {
    [self.animator removeAllBehaviors];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
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

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *recognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat currentY = [recognizer translationInView:self].y;
        CGFloat currentX = [recognizer translationInView:self].x;
        if (currentY == 0.0) {
            return YES;
        } else {
            if (fabs(currentX)/currentY >= 5.0) {
                return YES;
            } else {
                return NO;
            }
        }
    }
    return NO;
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.currentScrollY = self.mainScrollView.contentOffset.y;
            CGFloat currentY    = [recognizer translationInView:self].y;
            CGFloat currentX    = [recognizer translationInView:self].x;
            if (currentY == 0.0) {
                self.isVertical = YES;
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

#pragma mark - private methods
- (void)setupUI {
    self.mainScrollView = [[UIScrollView alloc] init];
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.mainScrollView.delegate = self;
    self.mainScrollView.contentSize = CGSizeMake(0, ScreenHeight + self.loopView.loopH);
    self.mainScrollView.bounces = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    self.mainScrollView.scrollEnabled = NO;
    [self addSubview:self.mainScrollView];
    
    [self.mainScrollView addSubview:self.loopView];
    [self.mainScrollView addSubview:self.articleView];
    
    self.panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    self.panGes.delegate = self;
    [self addGestureRecognizer:self.panGes];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    self.dynamicItem = [[MPDynamicItem alloc] init];
}

//控制上下滚动的方法
- (void)controlScrollForVertical:(CGFloat)detal AndState:(UIGestureRecognizerState)state {
    // 判断是MainScrollView滚动还是子ScrollView滚动,detal为手指移动的距离
    if (self.mainScrollView.contentOffset.y >= self.loopView.loopH) {
        CGFloat offsetY = self.articleView.listTableView.contentOffset.y - detal;
        if (offsetY < 0) {
            // 当子ScrollView的contentOffSet小于0之后就b不再移动子ScrollView,而要移动mainScrollView
            offsetY = 0;
            self.mainScrollView.contentOffset = CGPointMake(0, self.mainScrollView.contentOffset.y - detal);
        } else if (offsetY > (self.articleView.listTableView.contentSize.height - self.articleView.listTableView.frame.size.height)) {
            // 当子ScrollView的contenOffset大于tableView的可移动距离时
            offsetY = self.articleView.listTableView.contentOffset.y - rubberBandDistance(detal, ScreenHeight);
        }
        NSLog(@"subTableView %f",offsetY);
        self.articleView.listTableView.contentOffset = CGPointMake(0, offsetY);
    } else {
        CGFloat mainOffsetY = self.mainScrollView.contentOffset.y - detal;
        if (mainOffsetY < 0) {
            // 滚动到顶部之后继续往上滚动需要乘以一个小于1的系数
            mainOffsetY = self.mainScrollView.contentOffset.y - rubberBandDistance(detal, ScreenHeight);
            CGFloat subScrollViewOffsetY = self.articleView.listTableView.contentOffset.y - detal;
            if (subScrollViewOffsetY < 0) {
                // 触发子Scrollview下拉刷新
                mainOffsetY = 0;
                subScrollViewOffsetY = self.articleView.listTableView.contentOffset.y - rubberBandDistance(detal, ScreenHeight);
                self.articleView.listTableView.contentOffset = CGPointMake(0, subScrollViewOffsetY);
                if (subScrollViewOffsetY <= -30) {
                    [self.articleView manualTriggerArticleRefresh];
                }
            }
            NSLog(@"sub %f",subScrollViewOffsetY);
        } else if (mainOffsetY > self.loopView.loopH) {
            mainOffsetY = self.loopView.loopH;
        }
        NSLog(@"MainScrollView %f",mainOffsetY);
        self.mainScrollView.contentOffset = CGPointMake(0, mainOffsetY);
    }
    
    BOOL outsideFrame = [self outsideFrame];
    if (outsideFrame && (self.decelerationBehavior && !self.springBehavior)) {
        CGPoint target = CGPointZero;
        BOOL isMain = NO;
        if (self.mainScrollView.contentOffset.y < 0) {
            self.dynamicItem.center = self.mainScrollView.contentOffset;
            target = CGPointZero;
            isMain = YES;
        } else if (self.articleView.listTableView.contentOffset.y > (self.articleView.listTableView.contentSize.height - self.articleView.listTableView.frame.size.height)) {
            self.dynamicItem.center = self.articleView.listTableView.contentOffset;
            target.x = self.articleView.listTableView.contentOffset.x;
            target.y = self.articleView.listTableView.contentSize.height > self.articleView.listTableView.frame.size.height ? self.articleView.listTableView.contentSize.height - self.articleView.listTableView.frame.size.height : 0;
            isMain = NO;
        } else if (self.articleView.listTableView.contentOffset.y < 0) {
            self.dynamicItem.center = self.articleView.listTableView.contentOffset;
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
                    weakSelf.articleView.listTableView.contentOffset = CGPointZero;
                }
            } else {
                weakSelf.articleView.listTableView.contentOffset = weakSelf.dynamicItem.center;
                if (weakSelf.articleView.listTableView.mj_footer.refreshing) {
                    weakSelf.articleView.listTableView.contentOffset = CGPointMake(weakSelf.articleView.listTableView.contentOffset.x, weakSelf.articleView.listTableView.contentOffset.y + 44);
                } else if (weakSelf.articleView.listTableView.mj_header.refreshing) {
                    weakSelf.articleView.listTableView.contentOffset = CGPointMake(weakSelf.articleView.listTableView.contentOffset.x, weakSelf.articleView.listTableView.contentOffset.y + 44);
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
    if (self.articleView.listTableView.contentOffset.y < 0) {
        return YES;
    }
    if (self.articleView.listTableView.contentSize.height > self.articleView.listTableView.frame.size.height) {
        if (self.articleView.listTableView.contentOffset.y > (self.articleView.listTableView.contentSize.height - self.articleView.listTableView.frame.size.height)) {
            return YES;
        } else {
            return NO;
        }
    } else {
        if (self.articleView.listTableView.contentOffset.y > 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

#pragma mark - lazy
- (MPSheYingArticleView *)articleView {
    if (!_articleView) {
        _articleView = [[MPSheYingArticleView alloc] init];
    }
    return _articleView;
}

- (MPSheYingBannerLoopView *)loopView {
    if (!_loopView) {
        _loopView = [[MPSheYingBannerLoopView alloc] init];
    }
    return _loopView;
}

@end
