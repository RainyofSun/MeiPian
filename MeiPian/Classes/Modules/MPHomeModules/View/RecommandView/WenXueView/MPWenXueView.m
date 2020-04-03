//
//  MPWenXueView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPWenXueView.h"
#import "MPWenXueViewModel.h"
#import "MPOnePicTableViewCell.h"
#import "MPThreePicTableViewCell.h"

static NSString *RecommandOnePicCell        = @"OnePicCell";
static NSString *RecommandThreePicCell      = @"ThreePicCell";

@interface MPWenXueView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** listTableView */
@property (nonatomic,strong) MPBaseTableView *listTableView;
/** WXVM */
@property (nonatomic,strong) MPWenXueViewModel *WXVM;
/** WXArticleSource */
@property (nonatomic,strong) NSArray <MPWenXueConfigModel *>*WXArticleSource;
/** isLoadFirst */
@property (nonatomic,assign) BOOL isLoadFirst;

@end

@implementation MPWenXueView

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
    return self.WXArticleSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    return self.WXArticleSource[index.row].cellHeight;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPRecommadAllConfigModel *configModel = self.WXArticleSource[index.row];
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
    MPRecommadAllConfigModel *configModel = self.WXArticleSource[index.row];
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
    [self addSubview:self.listTableView];
    [self.listTableView registerClass:@"MPOnePicTableViewCell" forTableViewCellWithReuseIdentifier:RecommandOnePicCell withNibFile:YES];
       [self.listTableView registerClass:@"MPThreePicTableViewCell" forTableViewCellWithReuseIdentifier:RecommandThreePicCell withNibFile:YES];
    self.isLoadFirst = YES;
}

- (void)requestRecommandWenXueViewData:(MPLoadingType)loadType {
    WeakSelf;
    [self.WXVM MPRecommandArticleInfo:^(id  _Nonnull returnValue) {
        weakSelf.WXArticleSource = (NSArray <MPWenXueConfigModel *>*)returnValue;
        weakSelf.listTableView.isCompleteRequest = YES;
        weakSelf.isLoadFirst = NO;
    } requestType:loadType articleType:MPRecommandArticleType_WenXue];
}

#pragma mark - lazy
- (MPWenXueViewModel *)WXVM {
    if (!_WXVM) {
        _WXVM = [[MPWenXueViewModel alloc] init];
    }
    return _WXVM;
}

@end
