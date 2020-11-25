//
//  MPTopicView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPTopicView.h"
#import "MPTopicViewModel.h"
#import "MPTopicTableViewCell.h"

static NSString *TopicCellIndifier = @"topicCell";

@interface MPTopicView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** topicVM */
@property (nonatomic,strong) MPTopicViewModel *topicVM;
/** listTableView */
@property (nonatomic,strong) MPBaseTableView *listTableView;
/** topicArticleSource */
@property (nonatomic,strong) NSArray <MPTopicConfigModel *>*topicArticleSource;
/** isLoadFirst */
@property (nonatomic,assign) BOOL isLoadFirst;

@end

@implementation MPTopicView

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
    return self.topicArticleSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    return 95;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPTopicTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:TopicCellIndifier forIndex:index];
    [cell loadTopicCellSource:self.topicArticleSource[index.row]];
    return cell;
}

- (void)MPBaseTableView:(MPBaseTableView *)tableView didSelectedAtIndex:(NSIndexPath *)index {
    
}

- (void)MPBaseTableView:(MPBaseTableView *)tableView willDisplayCell:(UITableViewCell *)cell withRowAndIndex:(NSIndexPath *)index {
    MPTopicTableViewCell *topicCell = (MPTopicTableViewCell *)cell;
    [topicCell cellAlphaAnimation];
}

- (void)MPDropRefreshLoadMoreSource {
    [self requestRecommandWenXueViewData:(self.isLoadFirst ? MPLoadingType_Normal : MPLoadingType_Refresh)];
}

- (void)MPPullRefreshDataSource {
    [self requestRecommandWenXueViewData:MPLoadingType_More];
}

#pragma mark - private methods
- (void)setupUI {
    self.listTableView = [MPBaseTableView setupListView];
    self.listTableView.tableDalegate = self;
    self.listTableView.tableDataSource = self;
    self.listTableView.isOpenFooterRefresh = NO;
    [self addSubview:self.listTableView];
    [self.listTableView registerClass:@"MPTopicTableViewCell" forTableViewCellWithReuseIdentifier:TopicCellIndifier withNibFile:YES];
    self.isLoadFirst = YES;
}

- (void)requestRecommandWenXueViewData:(MPLoadingType)loadType {
    WeakSelf;
    [self.topicVM MPTopicArticleInfo:^(id  _Nonnull returnValue) {
        weakSelf.topicArticleSource = (NSArray <MPTopicConfigModel *>*)returnValue;
        weakSelf.listTableView.isCompleteRequest = YES;
        weakSelf.isLoadFirst = NO;
    } requestType:loadType];
}

#pragma mark - lazy
- (MPTopicViewModel *)topicVM {
    if (!_topicVM) {
        _topicVM = [[MPTopicViewModel alloc] init];
    }
    return _topicVM;
}

@end
