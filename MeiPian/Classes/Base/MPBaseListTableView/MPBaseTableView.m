//
//  MPBaseTableView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseTableView.h"
#import "MPDolphinRefreshHeader.h"
#import "MPAutoFooter.h"
#import "MPCustomSliderBarView.h"

@interface MPBaseTableView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MPCustomSliderBarDelegate>

/** customSliderBar */
@property (nonatomic,strong) MPCustomSliderBarView *customSliderBar;
/** defaultSliderBarH */
@property (nonatomic,assign) CGFloat defaultSliderBarH;

@end

@implementation MPBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self setDefaultData];
        [self setRefreshHeader];
        [self setRefreshFooter];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    NSLog(@"subviews %@",self.subviews);
//    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[UIImageView class]]) {
//            UIImageView *imgView = [[UIImageView alloc] init];
//            imgView = obj;
//            imgView.backgroundColor = [UIColor redColor];
//        }
//    }];
//    self.subviews.lastObject.width = 2;
//    self.subviews.lastObject.mj_x = 3;
}

- (void)dealloc {
    self.delegate = nil;
    self.dataSource = nil;
    self.tableDalegate = nil;
    self.tableDataSource = nil;
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
+ (MPBaseTableView *)setupListView {
    MPBaseTableView *tableView = [[MPBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    return tableView;
}

- (void)registerClass:(NSString *)cellClassName forTableViewCellWithReuseIdentifier:(NSString *)identifier withNibFile:(BOOL)hasXibFile {
    if (!identifier.length) {
        [NSException raise:@"This identifier must not be nil and must not be an empty string." format:@""];
    }
    if (hasXibFile) {
        [self registerNib:[UINib nibWithNibName:cellClassName bundle:nil] forCellReuseIdentifier:identifier];
    } else {
        [self registerClass:[NSClassFromString(cellClassName) class] forCellReuseIdentifier:identifier];
    }
}

- (UITableViewCell *)dequeueReusableTableViewCellWithIdentifier:(NSString *)identifier forIndex:(NSIndexPath *)index {
    if (!identifier.length) {
        [NSException raise:@"This identifier must not be nil and must not be an empty string." format:@""];
    }
    if (!index) {
        [NSException raise:@"please change an identifier" format:@""];
    }
    return [self dequeueReusableCellWithIdentifier:identifier forIndexPath:index];
}

- (UITableViewCell *)MPBaseTableViewCellForRowAtIndex:(NSIndexPath *)index {
    return [self cellForRowAtIndexPath:index];
}

- (void)customSliderBarShowAlphaAnimation {
    if (!self.isShowCustomSliderImgView) {
        return;
    }
    [UIView animateWithDuration:ALPHAANIMATIONTIME animations:^{
        self.customSliderBar.alpha = 1;
    }];
}

- (void)customSliderBarDisAlphaAnimation {
    if (!self.isShowCustomSliderImgView) {
           return;
    }
    [UIView animateWithDuration:ALPHAANIMATIONTIME delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.customSliderBar.alpha = 0;
    } completion:nil];
}

- (void)loadNewData {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPDropRefreshLoadMoreSource)]) {
        [self.tableDataSource MPDropRefreshLoadMoreSource];
    }
}

- (void)loadMoreData {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPPullRefreshDataSource)] && self.isOpenFooterRefresh) {
        [self.tableDataSource MPPullRefreshDataSource];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPNumberOfRowsInSection)]) {
        return [self.tableDataSource MPNumberOfRowsInSection];
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableDalegate != nil && [self.tableDalegate respondsToSelector:@selector(MPHeightForRowAtIndexPath:)]) {
        return [self.tableDalegate MPHeightForRowAtIndexPath:indexPath];
    } else {
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPBaseTableView:cellForRowAtIndexPath:)]) {
        return [self.tableDataSource MPBaseTableView:self cellForRowAtIndexPath:indexPath];
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableDalegate != nil && [self.tableDalegate respondsToSelector:@selector(MPBaseTableView:didSelectedAtIndex:)]) {
        [self.tableDalegate MPBaseTableView:self didSelectedAtIndex:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self updateSliderBarHeight];
    if (self.tableDalegate != nil && [self.tableDalegate respondsToSelector:@selector(MPBaseTableView:willDisplayCell:withRowAndIndex:)]) {
        [self.tableDalegate MPBaseTableView:self willDisplayCell:cell withRowAndIndex:indexPath];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isShowCustomSliderImgView || scrollView.contentOffset.y < 0) {
        return;
    }
    // 更新滚动条位置
    self.customSliderBar.yPosition = (self.customSliderBar.bounds.size.height - self.customSliderBar.barHeight) * scrollView.contentOffset.y / (scrollView.contentSize.height - self.customSliderBar.bounds.size.height);
}

#pragma mark - MPCustomSliderBarDelegate
- (void)scrollBarDidiScroll:(MPCustomSliderBarView *)scrollBar {
    [self setContentOffset:CGPointMake(0, (self.contentSize.height - self.customSliderBar.bounds.size.height) * scrollBar.yPosition / (self.customSliderBar.bounds.size.height - self.customSliderBar.barHeight)) animated:YES];
}

- (void)scrollBarTouchAction:(MPCustomSliderBarView *)scrollBar {
    [UIView animateWithDuration:scrollBar.barMoveDuration animations:^{
        [self setContentOffset:CGPointMake(0, (self.contentSize.height - self.customSliderBar.bounds.size.height) * scrollBar.yPosition / (self.customSliderBar.bounds.size.height - self.customSliderBar.barHeight)) animated:YES];
    }];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.backgroundColor = MAIN_LIGHT_GRAY_COLOR;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.isOpenFooterRefresh = YES;
    self.isShowCustomSliderImgView = NO;
    self.defaultSliderBarH = 40;
}

- (void)setRefreshHeader {
    self.mj_header = [MPDolphinRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.mj_header beginRefreshing];
}

- (void)setRefreshFooter {
    MPAutoFooter *footer = [MPAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.triggerAutomaticallyRefreshPercent = 0.3;
    self.mj_footer = footer;
}

- (void)setCustomSliderBarView {
    if (_customSliderBar) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.customSliderBar = [[MPCustomSliderBarView alloc] initWithFrame:CGRectMake(CGRectGetMaxX([UIScreen mainScreen].bounds) - 5, 0, 3, CGRectGetHeight(self.bounds))];
        self.customSliderBar.alpha = 0;
        self.customSliderBar.minBarHeight = self.defaultSliderBarH;
        self.customSliderBar.sliderBarDelegate = self;
        [self.superview addSubview:self.customSliderBar];
    });
}

- (void)updateSliderBarHeight {
    if (!self.isShowCustomSliderImgView) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 更新滚动条高度
        if (self.contentSize.height <= self.bounds.size.height) {
            self.customSliderBar.barHeight = self.defaultSliderBarH;
        } else {
            self.customSliderBar.barHeight = pow(self.bounds.size.height, 2) / self.contentSize.height;
        }
        // 更新滚动条Y位置
        self.customSliderBar.yPosition = (self.bounds.size.height - self.customSliderBar.barHeight) * self.contentOffset.y / (self.contentSize.height - self.customSliderBar.bounds.size.height);
    });
}

#pragma mark - setter
- (void)setIsCompleteRequest:(BOOL)isCompleteRequest {
    _isCompleteRequest = isCompleteRequest;
    if (isCompleteRequest) {
        if (self.mj_header.isRefreshing) {
            [self.mj_header endRefreshing];
        } else if (self.mj_footer.isRefreshing) {
            [self.mj_footer endRefreshing];
        }
    }
    [self reloadData];
}

- (void)setIsShowCustomSliderImgView:(BOOL)isShowCustomSliderImgView {
    _isShowCustomSliderImgView = isShowCustomSliderImgView;
    if (isShowCustomSliderImgView) {
        [self setCustomSliderBarView];
    }
}

- (void)setSliderBarForeColor:(UIColor *)sliderBarForeColor {
    _sliderBarBackColor = sliderBarForeColor;
    if (self.isShowCustomSliderImgView) {
        self.customSliderBar.foreColor = sliderBarForeColor;
    }
}

- (void)setSliderBarBackColor:(UIColor *)sliderBarBackColor {
    _sliderBarBackColor = sliderBarBackColor;
    if (self.isShowCustomSliderImgView) {
        self.customSliderBar.backColor = sliderBarBackColor;
    }
}

- (void)setSliderBarMinHeight:(CGFloat)sliderBarMinHeight {
    _sliderBarMinHeight = sliderBarMinHeight;
    if (self.isShowCustomSliderImgView) {
        self.customSliderBar.minBarHeight = sliderBarMinHeight;
    }
}

@end
