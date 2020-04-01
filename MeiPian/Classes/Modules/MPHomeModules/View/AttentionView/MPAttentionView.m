//
//  MPAttentionView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAttentionView.h"
#import "MPMoreInterestingTableViewCell.h"
#import "MPInterestingPeopleTableViewCell.h"
#import "MPAttentionViewModel.h"

static NSString *MoreInterestingCellIndifier    = @"MoreInterestingCell";
static NSString *InterestingPeopleIndifier      = @"InsterestingPelpleCell";
static NSString *InterestingTipCellIndifier     = @"InsterestingTipCell";

@interface MPAttentionView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** listTableView */
@property (nonatomic,strong) MPBaseTableView *listTableView;
/** attentionVM  */
@property (nonatomic,strong) MPAttentionViewModel *attentionVM;
/** attentionSource */
@property (nonatomic,strong) NSArray <MPAttentionModelConfig *>*attentionSource;
/** loadFirst */
@property (nonatomic,assign) BOOL loadFirst;

@end

@implementation MPAttentionView

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
    return self.attentionSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    return self.attentionSource[index.row].cellHeight;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPAttentionCellStyle cellStyle = self.attentionSource[index.row].cellType;
    switch (cellStyle) {
        case MPAttentionCellStyle_MorePeople:
        {
            MPMoreInterestingTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:MoreInterestingCellIndifier forIndex:index];
            [cell loadFindMoreModel:self.attentionSource[index.row]];
            return cell;
        }
        case MPAttentionCellStyle_TopTip:
        {
            MPInterestingTipCell *tipCell = [tableView dequeueReusableTableViewCellWithIdentifier:InterestingTipCellIndifier forIndex:index];
            return tipCell;
        }
        case MPAttentionCellStyle_People:
        {
            MPInterestingPeopleTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:InterestingPeopleIndifier forIndex:index];
            [cell loadInterestUsersInfo:self.attentionSource[index.row]];
            return cell;
        }
        default:
            break;
    }
}

- (void)MPBaseTableView:(MPBaseTableView *)tableView willDisplayCell:(UITableViewCell *)cell withRowAndIndex:(NSIndexPath *)index {
    if ([cell isKindOfClass:[MPInterestingPeopleTableViewCell class]]) {
        MPInterestingPeopleTableViewCell *interestCell = (MPInterestingPeopleTableViewCell *)cell;
        [interestCell cellAlphaAnimation];
    }
}

- (void)MPDropRefreshLoadMoreSource {
    [self requestData:(self.loadFirst ? MPLoadingType_Normal : MPLoadingType_Refresh)];
}

- (void)MPPullRefreshDataSource {
    [self requestData:MPLoadingType_More];
}

#pragma mark - private methods
- (void)setupUI {
    self.listTableView = [MPBaseTableView setupListView];
    [self.listTableView registerClass:@"MPMoreInterestingTableViewCell" forTableViewCellWithReuseIdentifier:MoreInterestingCellIndifier withNibFile:YES];
    [self.listTableView registerClass:@"MPInterestingPeopleTableViewCell" forTableViewCellWithReuseIdentifier:InterestingPeopleIndifier withNibFile:YES];
    [self.listTableView registerClass:@"MPInterestingTipCell" forTableViewCellWithReuseIdentifier:InterestingTipCellIndifier withNibFile:NO];
    self.listTableView.tableDalegate = self;
    self.listTableView.tableDataSource = self;
    [self addSubview:self.listTableView];
    self.loadFirst = YES;
}

- (void)requestData:(MPLoadingType)loadType {
    WeakSelf;
    [self.attentionVM MPAttentionPeopleInfo:^(id  _Nonnull returnValue) {
        weakSelf.attentionSource = (NSArray <MPAttentionModelConfig *>*)returnValue;
        weakSelf.listTableView.isCompleteRequest = YES;
        weakSelf.loadFirst = NO;
    } requestType:loadType];
}

#pragma mark - lazy
- (MPAttentionViewModel *)attentionVM {
    if (!_attentionVM) {
        _attentionVM = [[MPAttentionViewModel alloc] init];
    }
    return _attentionVM;
}

@end
