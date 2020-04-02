//
//  MPJingXuanView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPJingXuanView.h"
#import "MPJXTableViewCell.h"
#import "MPJingXuanViewModel.h"

static NSString *RecommandJXCell    = @"JXCell";

@interface MPJingXuanView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** listTableView */
@property (nonatomic,strong) MPBaseTableView *listTableView;
/** JXVM */
@property (nonatomic,strong) MPJingXuanViewModel *JXVM;
/** JXArticleSource */
@property (nonatomic,strong) NSArray <MPJingXuanConfigModel *>*JXArticleSource;
/** isLoadFirst */
@property (nonatomic,assign) BOOL isLoadFirst;

@end

@implementation MPJingXuanView

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

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfRowsInSection {
    return self.JXArticleSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    return 95;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPJXTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:RecommandJXCell forIndex:index];
    [cell loadJingXuanCellSource:self.JXArticleSource[index.row]];
    return cell;
}

- (void)MPBaseTableView:(MPBaseTableView *)tableView didSelectedAtIndex:(NSIndexPath *)index {
    MPJXTableViewCell *cell = [tableView MPBaseTableViewCellForRowAtIndex:index];
    [cell loadJingXuanCellSource:[self.JXVM modifyJingXuanModelData:index.row]];
}

- (void)MPDropRefreshLoadMoreSource {
    [self requestRecommandJingXuanViewData:(self.isLoadFirst ? MPLoadingType_Normal : MPLoadingType_Refresh)];
}

- (void)MPPullRefreshDataSource {
    [self requestRecommandJingXuanViewData:MPLoadingType_More];
}

#pragma mark - private methods
- (void)setupUI {
    self.listTableView = [MPBaseTableView setupListView];
    self.listTableView.tableDalegate = self;
    self.listTableView.tableDataSource = self;
    [self.listTableView registerClass:@"MPJXTableViewCell" forTableViewCellWithReuseIdentifier:RecommandJXCell withNibFile:YES];
    [self addSubview:self.listTableView];
    self.isLoadFirst = YES;
}

- (void)requestRecommandJingXuanViewData:(MPLoadingType)loadType {
    WeakSelf;
    [self.JXVM MPRecommandArticleInfo:^(id  _Nonnull returnValue) {
        weakSelf.JXArticleSource = (NSArray <MPJingXuanConfigModel *>*)returnValue;
        weakSelf.listTableView.isCompleteRequest = YES;
        weakSelf.isLoadFirst = NO;
    } requestType:loadType articleType:MPRecommandArticleType_JingXuan];
}

#pragma mark - lazy
- (MPJingXuanViewModel *)JXVM {
    if (!_JXVM) {
        _JXVM = [[MPJingXuanViewModel alloc] init];
    }
    return _JXVM;
}

@end
