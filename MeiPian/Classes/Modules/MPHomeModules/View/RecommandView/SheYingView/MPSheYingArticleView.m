//
//  MPSheYingArticleView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/2.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPSheYingArticleView.h"
#import "MPSheYingViewModel.h"
#import "MPOnePicTableViewCell.h"
#import "MPThreePicTableViewCell.h"

static NSString *RecommandOnePicCell        = @"OnePicCell";
static NSString *RecommandThreePicCell      = @"ThreePicCell";

@interface MPSheYingArticleView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** SYVM */
@property (nonatomic,strong) MPSheYingViewModel *SYVM;
/** SYArticleSource */
@property (nonatomic,strong) NSArray <MPSheYingConfigModel *>*SYArticleSource;
/** isLoadFirst */
@property (nonatomic,assign) BOOL isLoadFirst;
/** manualRefreshStart */
@property (nonatomic,assign) BOOL manualRefreshStart;

@end

@implementation MPSheYingArticleView

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
    return self.SYArticleSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    return self.SYArticleSource[index.row].cellHeight;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPRecommadAllConfigModel *configModel = self.SYArticleSource[index.row];
    switch (configModel.cellType) {
        case RecommandAllArticleCellStyle_OnePic:
        {
            MPOnePicTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:RecommandOnePicCell forIndex:index];
            [cell loadOnePicArticleDataSource:configModel];
            return cell;
        }
        case RecommandAllArticleCellStyle_ThreePic:
        {
            MPThreePicTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:RecommandThreePicCell forIndex:index];
            [cell loadThreePicArticleDataSource:configModel];
            return cell;
        }
        default:
            break;
    }
    return nil;
}

- (void)MPBaseTableView:(MPBaseTableView *)tableView willDisplayCell:(UITableViewCell *)cell withRowAndIndex:(NSIndexPath *)index {
    MPRecommadAllConfigModel *configModel = self.SYArticleSource[index.row];
    switch (configModel.cellType) {
        case RecommandAllArticleCellStyle_OnePic:
        {
            MPOnePicTableViewCell *onePicCell = (MPOnePicTableViewCell *)cell;
            [onePicCell cellAlphaAnimation];
        }
            break;
        case RecommandAllArticleCellStyle_ThreePic:
        {
            MPThreePicTableViewCell *threePicCell = (MPThreePicTableViewCell *)cell;
            [threePicCell cellAlphaAnimation];
        }
        default:
            break;
    }
}

- (void)MPDropRefreshLoadMoreSource {
    [self requestRecommandSheYingViewData:(self.isLoadFirst ? MPLoadingType_Normal : MPLoadingType_Refresh)];
}

- (void)MPPullRefreshDataSource {
    [self requestRecommandSheYingViewData:MPLoadingType_More];
}

#pragma mark - private methods
- (void)setupUI {
    self.listTableView = [MPBaseTableView setupListView];
    self.listTableView.tableDalegate = self;
    self.listTableView.tableDataSource = self;
    self.listTableView.scrollEnabled = NO;
    [self addSubview:self.listTableView];
    self.listTableView.isShowCustomSliderImgView = YES;
    [self.listTableView registerClass:@"MPOnePicTableViewCell" forTableViewCellWithReuseIdentifier:RecommandOnePicCell withNibFile:YES];
       [self.listTableView registerClass:@"MPThreePicTableViewCell" forTableViewCellWithReuseIdentifier:RecommandThreePicCell withNibFile:YES];
    self.isLoadFirst = YES;
    self.manualRefreshStart = NO;
}

- (void)requestRecommandSheYingViewData:(MPLoadingType)loadType {
    WeakSelf;
    [self.SYVM MPRecommandArticleInfo:^(id  _Nonnull returnValue) {
        weakSelf.SYArticleSource = (NSArray <MPSheYingConfigModel *>*)returnValue;
        weakSelf.listTableView.isCompleteRequest = YES;
        weakSelf.isLoadFirst = NO;
        [weakSelf resetManualTriggerStatus];
    } requestType:loadType articleType:MPRecommandArticleType_SheYing];
}

#pragma mark - lazy
- (MPSheYingViewModel *)SYVM{
    if(!_SYVM) {
        _SYVM = [[MPSheYingViewModel alloc] init];
    }
    return _SYVM;
}

@end
