//
//  MPQingGanView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPQingGanView.h"
#import "MPQingGanViewModel.h"
#import "MPOnePicTableViewCell.h"
#import "MPThreePicTableViewCell.h"

static NSString *RecommandOnePicCell        = @"OnePicCell";
static NSString *RecommandThreePicCell      = @"ThreePicCell";

@interface MPQingGanView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** listTableView */
@property (nonatomic,strong) MPBaseTableView *listTableView;
/** QGVM */
@property (nonatomic,strong) MPQingGanViewModel *QGVM;
/** QGArticleSource */
@property (nonatomic,strong) NSArray <MPQingGanConfigModel *>*QGArticleSource;
/** isLoadFirst */
@property (nonatomic,assign) BOOL isLoadFirst;

@end

@implementation MPQingGanView

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
    return self.QGArticleSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    return self.QGArticleSource[index.row].cellHeight;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPRecommadAllConfigModel *configModel = self.QGArticleSource[index.row];
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
    MPRecommadAllConfigModel *configModel = self.QGArticleSource[index.row];
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
    [self requestRecommandQingGanViewData:(self.isLoadFirst ? MPLoadingType_Normal : MPLoadingType_Refresh)];
}

- (void)MPPullRefreshDataSource {
    [self requestRecommandQingGanViewData:MPLoadingType_More];
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

- (void)requestRecommandQingGanViewData:(MPLoadingType)loadType {
    WeakSelf;
    [self.QGVM MPRecommandArticleInfo:^(id  _Nonnull returnValue) {
        weakSelf.QGArticleSource = (NSArray <MPQingGanConfigModel *>*)returnValue;
        weakSelf.listTableView.isCompleteRequest = YES;
        weakSelf.isLoadFirst = NO;
    } requestType:loadType articleType:MPRecommandArticleType_QingGan];
}

#pragma mark - lazy
- (MPQingGanViewModel *)QGVM {
    if (!_QGVM) {
        _QGVM = [[MPQingGanViewModel alloc] init];
    }
    return _QGVM;
}

@end
