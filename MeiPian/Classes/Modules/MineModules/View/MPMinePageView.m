//
//  MPMinePageView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMinePageView.h"
#import "MPMineInfoTableViewCell.h"
#import "MPMineArticleTableViewCell.h"
#import "MPMineSliderBarView.h"
#import "MPMineViewModel.h"
#import "MPDynamicItem.h"

static NSString *InfoCell = @"MineInfoCell";
static NSString *ArticleCell = @"MineArticleCell";
static NSString *SectionHeaderIdentifier = @"ArticleHeader";

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

@interface MPMinePageView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource,UIGestureRecognizerDelegate,UIDynamicAnimatorDelegate>

/** mineListView */
@property (nonatomic,strong) MPBaseTableView *mineListView;
/** sliderBarView */
@property (nonatomic,strong) MPMineSliderBarView *sliderBarView;
/** mineVM */
@property (nonatomic,strong) MPMineViewModel *mineVM;
/** mineSource */
@property (nonatomic,strong) NSArray <MPMineConfigModel *>*mineSource;
/** sliderbarSelectedIndex */
@property (nonatomic,assign) NSInteger sliderbarSelectedIndex;
/** isNeedRefreshSliderBarSource */
@property (nonatomic,assign) BOOL isNeedRefreshSliderBarSource;
/** mineInfoH */
@property (nonatomic,assign) CGFloat mineInfoH;

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
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mineListView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    [self.animator removeAllBehaviors];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - 消息透传
// 切换sliderBar
- (void)switchSliderBar:(NSNumber *)senderTag {
    self.sliderbarSelectedIndex = senderTag.integerValue;
    [self.sliderBarView switchSliderBarSlectedItem:senderTag];
    self.mineListView.isCompleteRequest = YES;
}

// 重新调整偏移量
- (void)resetScrollViewContentOffset:(NSNumber *)senderTag {
    self.sliderbarSelectedIndex = senderTag.integerValue;
    MPMineArticleTableViewCell *cell = [self.mineListView MPBaseTableViewCellForRowAtIndex:[NSIndexPath indexPathForRow:0 inSection:(self.mineSource.count - 1)]];
    [cell resetSubScrollViewContentOffSet:senderTag];
    self.mineListView.isCompleteRequest = YES;
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfSections {
    return self.mineSource.count;
}

- (NSInteger)MPNumberOfRowsInSection {
    return 1;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    if (index.section == 0) {
        self.mineInfoH = self.mineSource[index.section].cellHeightSource.firstObject.floatValue;
        return self.mineInfoH;
    } else {
        return self.mineSource[index.section].cellHeightSource[self.sliderbarSelectedIndex].floatValue;
    }
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    switch (self.mineSource[index.section].cellType) {
        case MineCellStyle_info:
        {
            MPMineInfoTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:InfoCell forIndex:index];
            [cell loadMineInfoSource:self.mineSource[index.section].infoModel];
            return cell;
        }
        case MineCellStyle_Article:
        {
            MPMineArticleTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:ArticleCell forIndex:index];
            [cell loadMineArticleSource:self.mineSource[index.section].articleModel];
            return cell;
        }
        default:
            break;
    }
    return nil;
}

- (UIView *)MPBaseTableView:(MPBaseTableView *)tableview headerFooterInSection:(NSInteger)section isSectionHeader:(BOOL)sectionHeader {
    if (sectionHeader) {
        if (section == 0) {
            return nil;
        }
        self.sliderBarView = [tableview dequeueCustomReusableHeaderFooterViewWithIdentifier:SectionHeaderIdentifier];
        self.isNeedRefreshSliderBarSource ? [self.sliderBarView loadSliderBarTitleSource:self.mineSource[section].sliderTitleSource] : nil;
        self.isNeedRefreshSliderBarSource = NO;
        return self.sliderBarView;
    }
    return nil;
}

- (CGFloat)MPHeightForHeaderInSection:(NSInteger)index isSectionHeader:(BOOL)sectionHeader {
    if (sectionHeader) {
        return index == 1 ? 50 : 0.00001;
    } else {
        return 0.00001;
    }
}

- (void)MPDropRefreshLoadMoreSource {
    [self requestMineInfo];
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
            self.currentScrollY = self.mineListView.contentOffset.y;
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
//    [self.interestView.listTableView customSliderBarDisAlphaAnimation];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.sliderbarSelectedIndex = 0;
    self.isNeedRefreshSliderBarSource = YES;
}

- (void)setupUI {
    self.mineListView = [MPBaseTableView setupListView];
    self.mineListView.tableDalegate = self;
    self.mineListView.tableDataSource = self;
    self.mineListView.isOpenFooterRefresh = NO;
    [self addSubview:self.mineListView];
    [self.mineListView registerClass:@"MPMineInfoTableViewCell" forTableViewCellWithReuseIdentifier:InfoCell withNibFile:YES];
    [self.mineListView registerClass:@"MPMineArticleTableViewCell" forTableViewCellWithReuseIdentifier:ArticleCell withNibFile:NO];
    [self.mineListView registerClass:@"MPMineSliderBarView" forHeaderFooterViewReuseIdentifier:SectionHeaderIdentifier withNibFile:NO isSectionHeader:YES];
    self.mineListView.scrollEnabled = NO;
    
    self.panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
    self.panGes.delegate = self;
    [self addGestureRecognizer:self.panGes];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    self.animator.delegate = self;
    self.dynamicItem = [[MPDynamicItem alloc] init];
}

//控制上下滚动的方法
- (void)controlScrollForVertical:(CGFloat)detal AndState:(UIGestureRecognizerState)state {
    // 判断是MainScrollView滚动还是子ScrollView滚动,detal为手指移动的距离
    MPBaseTableView *subView = [self getSubTableView];
    if (self.mineListView.contentOffset.y >= self.mineInfoH) {
//        [self.interestView.listTableView customSliderBarShowAlphaAnimation];
        CGFloat offsetY = subView.contentOffset.y - detal;
        if (offsetY < 0) {
            // 当子ScrollView的contentOffSet小于0之后就b不再移动子ScrollView,而要移动mainScrollView
            offsetY = 0;
            self.mineListView.contentOffset = CGPointMake(0, self.mineListView.contentOffset.y - detal);
        } else if (offsetY > (subView.contentSize.height - subView.frame.size.height)) {
            // 当子ScrollView的contenOffset大于tableView的可移动距离时
            offsetY =subView.contentOffset.y - rubberBandDistance(detal, CGRectGetHeight(self.bounds));
        }
        NSLog(@"subTableView %f",offsetY);
        subView.contentOffset = CGPointMake(0, offsetY);
    } else {
        CGFloat mainOffsetY = self.mineListView.contentOffset.y - detal;
        if (mainOffsetY < 0) {
            // 滚动到顶部之后继续往上滚动需要乘以一个小于1的系数
            mainOffsetY = self.mineListView.contentOffset.y - rubberBandDistance(detal, CGRectGetHeight(self.bounds));
        } else if (mainOffsetY > self.mineInfoH) {
            mainOffsetY = self.mineInfoH;
        }
        NSLog(@"MainScrollView %f",mainOffsetY);
        self.mineListView.contentOffset = CGPointMake(0, mainOffsetY);
    }
    
    BOOL outsideFrame = [self outsideFrame];
    if (outsideFrame && (self.decelerationBehavior && !self.springBehavior)) {
        CGPoint target = CGPointZero;
        BOOL isMain = NO;
        if (self.mineListView.contentOffset.y < 0) {
            self.dynamicItem.center = self.mineListView.contentOffset;
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
                weakSelf.mineListView.contentOffset = weakSelf.dynamicItem.center;
                if (weakSelf.mineListView.contentOffset.y == 0) {
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
    if (self.mineListView.contentOffset.y < 0) {
        return YES;
    }
    MPBaseTableView *subView = [self getSubTableView];
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

- (MPBaseTableView *)getSubTableView {
    MPMineArticleTableViewCell *cell = [self.mineListView MPBaseTableViewCellForRowAtIndex:[NSIndexPath indexPathForRow:0 inSection:(self.mineSource.count - 1)]];
    return [cell getArticleCellTableView];
}

- (void)requestMineInfo {
    WeakSelf;
    [self.mineVM MPMineInfoRequest:^(id  _Nonnull returnValue) {
        weakSelf.mineSource = (NSArray <MPMineConfigModel *>*)returnValue;
        weakSelf.mineListView.isCompleteRequest = YES;
    }];
}

#pragma mark - lazy
- (MPMineViewModel *)mineVM {
    if (!_mineVM) {
        _mineVM = [[MPMineViewModel alloc] init];
    }
    return _mineVM;
}

@end
