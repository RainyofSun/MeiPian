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
/** editingStyle */
@property (nonatomic,assign) UITableViewCellEditingStyle editingStyle;

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
        return;
    }
    if (hasXibFile) {
        [self registerNib:[UINib nibWithNibName:cellClassName bundle:nil] forCellReuseIdentifier:identifier];
    } else {
        [self registerClass:[NSClassFromString(cellClassName) class] forCellReuseIdentifier:identifier];
    }
}

- (void)registerClass:(NSString *)headerFooterName forHeaderFooterViewReuseIdentifier:(NSString *)identifier withNibFile:(BOOL)hasXibFile isSectionHeader:(BOOL)sectionHeader {
    if (!identifier.length) {
        [NSException raise:@"This identifier must not be nil and must not be an empty string." format:@""];
        return;
    }
    if (hasXibFile) {
        [self registerNib:[UINib nibWithNibName:headerFooterName bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];
    } else {
        [self registerClass:[NSClassFromString(headerFooterName) class] forHeaderFooterViewReuseIdentifier:identifier];
    }
}

- (UITableViewCell *)dequeueReusableTableViewCellWithIdentifier:(NSString *)identifier forIndex:(NSIndexPath *)index {
    if (!identifier.length) {
        [NSException raise:@"This identifier must not be nil and must not be an empty string." format:@""];
        return nil;
    }
    if (!index) {
        [NSException raise:@"please change an identifier" format:@""];
        return nil;
    }
    return [self dequeueReusableCellWithIdentifier:identifier forIndexPath:index];
}

- (UITableViewHeaderFooterView *)dequeueCustomReusableHeaderFooterViewWithIdentifier:(NSString *)identifier {
    if (!identifier.length) {
        [NSException raise:@"This identifier must not be nil and must not be an empty string." format:@""];
        return nil;
    }
    return [self dequeueReusableHeaderFooterViewWithIdentifier:identifier];
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
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPDropRefreshLoadMoreSource)] && self.isOpenHeaderRefresh) {
        [self.tableDataSource MPDropRefreshLoadMoreSource];
    }
}

- (void)loadMoreData {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPPullRefreshDataSource)] && self.isOpenFooterRefresh) {
        [self.tableDataSource MPPullRefreshDataSource];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPNumberOfSections)]) {
        return [self.tableDataSource MPNumberOfSections];
    } else {
        return 1;
    }
}

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

// 编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.isOpenEdit;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPBaseTableViewEditingStyleForRowAtIndexPath:)] && self.isOpenEdit) {
        self.editingStyle = [self.tableDataSource MPBaseTableViewEditingStyleForRowAtIndexPath:indexPath];
    }
    return self.editingStyle;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == self.editingStyle) {
        if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPBaseTableViewCellEditingAtIndexPath:)] && self.isOpenEdit) {
            [self.tableDataSource MPBaseTableViewCellEditingAtIndexPath:indexPath];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.editingStyle) {
        case UITableViewCellEditingStyleDelete:
            return @"删除";
        case UITableViewCellEditingStyleInsert:
            return @"插入";
        default:
            return @"";
    }
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPBaseTableViewTrailingSwipeActionsConfigurationForRowAtIndexPath:)] && self.isOpenEdit) {
        return [self.tableDataSource MPBaseTableViewTrailingSwipeActionsConfigurationForRowAtIndexPath:indexPath];
    } else {
        return nil;
    }
}

// 组头组尾视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPBaseTableView:headerFooterInSection:isSectionHeader:)]) {
        return [self.tableDataSource MPBaseTableView:self headerFooterInSection:section isSectionHeader:YES];
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.tableDalegate != nil && [self.tableDalegate respondsToSelector:@selector(MPHeightForHeaderInSection:isSectionHeader:)]) {
       return [self.tableDalegate MPHeightForHeaderInSection:section isSectionHeader:YES];
    } else {
        return 0.00001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPBaseTableView:headerFooterInSection:isSectionHeader:)]) {
        return [self.tableDataSource MPBaseTableView:self headerFooterInSection:section isSectionHeader:NO];
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.tableDalegate != nil && [self.tableDalegate respondsToSelector:@selector(MPHeightForHeaderInSection:isSectionHeader:)]) {
       return [self.tableDalegate MPHeightForHeaderInSection:section isSectionHeader:NO];
    } else {
        return 0.00001;
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
    self.isOpenHeaderRefresh = YES;
    self.isOpenEdit          = NO;
    self.isShowCustomSliderImgView = NO;
    self.editingStyle        = UITableViewCellEditingStyleDelete;
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

- (void)setIsOpenHeaderRefresh:(BOOL)isOpenHeaderRefresh {
    _isOpenHeaderRefresh = isOpenHeaderRefresh;
    if (!isOpenHeaderRefresh) {
        [self.mj_header endRefreshing];
        [self.mj_header removeFromSuperview];
    }
}

- (void)setIsOpenFooterRefresh:(BOOL)isOpenFooterRefresh {
    _isOpenFooterRefresh = isOpenFooterRefresh;
    if (!isOpenFooterRefresh) {
        [self.mj_footer endRefreshing];
        [self.mj_footer removeFromSuperview];
    }
}

@end
