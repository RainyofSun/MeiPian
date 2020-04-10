//
//  MPInterestingCircleArticleView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPInterestingCircleArticleView.h"
#import "MPInterestTableViewCell.h"
#import "MPCircleInterestViewModel.h"

static NSString *InterestCell = @"InterestIngCell";

@interface MPInterestingCircleArticleView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** interestVM */
@property (nonatomic,strong) MPCircleInterestViewModel *interestVM;
/** interestArticleSource */
@property (nonatomic,strong) NSArray <MPCircleInterestArticleConfigModel *>*interestArticleSource;
/** isLoadFirst */
@property (nonatomic,assign) BOOL isLoadFirst;
/** manualRefreshStart */
@property (nonatomic,assign) BOOL manualRefreshStart;

@end

@implementation MPInterestingCircleArticleView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.listTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)manualTriggerArticleRefresh {
    if (self.manualRefreshStart) {
        NSLog(@"拦截无效刷新");
        return;
    }
    NSLog(@"触发手动刷新");
    self.manualRefreshStart = YES;
    [self.listTableView.mj_header beginRefreshing];
}

- (void)resetManualTriggerStatus {
    NSLog(@"重置手动刷新状态");
    self.manualRefreshStart = NO;
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfRowsInSection {
    return self.interestArticleSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    return 140;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPInterestTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:InterestCell forIndex:index];
    [cell loadInterestCellSource:self.interestArticleSource[index.row]];
    return cell;
}

- (void)MPBaseTableView:(MPBaseTableView *)tableView willDisplayCell:(UITableViewCell *)cell withRowAndIndex:(NSIndexPath *)index {
    MPInterestTableViewCell *interestCell = (MPInterestTableViewCell *)cell;
    [interestCell cellAlphaAnimation];
}

- (void)MPDropRefreshLoadMoreSource {
    [self requestRecommandInterestViewData:(self.isLoadFirst ? MPLoadingType_Normal : MPLoadingType_Refresh)];
}

- (void)MPPullRefreshDataSource {
    [self requestRecommandInterestViewData:MPLoadingType_More];
}

#pragma mark - private methods
- (void)setupUI {
    self.listTableView = [MPBaseTableView setupListView];
    self.listTableView.tableDalegate = self;
    self.listTableView.tableDataSource = self;
    self.listTableView.scrollEnabled = NO;
    [self addSubview:self.listTableView];
    self.listTableView.isShowCustomSliderImgView = YES;
    [self.listTableView registerClass:@"MPInterestTableViewCell" forTableViewCellWithReuseIdentifier:InterestCell withNibFile:YES];
    self.isLoadFirst = YES;
    self.manualRefreshStart = NO;
}

- (void)requestRecommandInterestViewData:(MPLoadingType)loadType {
    WeakSelf;
    [self.interestVM MPInterestArticleInfo:^(id  _Nonnull returnValue) {
        weakSelf.interestArticleSource = (NSArray <MPCircleInterestArticleConfigModel *>*)returnValue;
        weakSelf.listTableView.isCompleteRequest = YES;
        weakSelf.isLoadFirst = NO;
        [weakSelf resetManualTriggerStatus];
    } loadType:loadType];
}

#pragma mark - lazy
- (MPCircleInterestViewModel *)interestVM {
    if (!_interestVM) {
        _interestVM = [[MPCircleInterestViewModel alloc] init];
    }
    return _interestVM;
}

@end
