//
//  MPRecommandAllView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommandAllView.h"
#import "MPOnePicTableViewCell.h"
#import "MPThreePicTableViewCell.h"
#import "MPAdvertisingVideoTableViewCell.h"
#import "MPRecommandAllViewModel.h"

static NSString *RecommandOnePicCell        = @"OnePicCell";
static NSString *RecommandThreePicCell      = @"ThreePicCell";
static NSString *RecommandAdvertisingCell   = @"AdvertisingVideoCell";

@interface MPRecommandAllView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** listTableView */
@property (nonatomic,strong) MPBaseTableView *listTableView;
/** recommandVM */
@property (nonatomic,strong) MPRecommandAllViewModel *recommandVM;
/** allArticleSource */
@property (nonatomic,strong) NSArray <MPRecommadAllConfigModel *>*allArticleSource;
/** isFirstLoad */
@property (nonatomic,assign) BOOL isFirstLoad;

@end

@implementation MPRecommandAllView

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
    return self.allArticleSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    return self.allArticleSource[index.row].cellHeight;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPRecommadAllConfigModel *configModel = self.allArticleSource[index.row];
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
    MPRecommadAllConfigModel *configModel = self.allArticleSource[index.row];
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

- (void)MPBaseTableView:(MPBaseTableView *)tableView didSelectedAtIndex:(NSIndexPath *)index {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(selectedArticle:) params:ArticleURL(self.allArticleSource[index.row].recommandAllModel.article.mask_id)];
}

- (void)MPDropRefreshLoadMoreSource {
    [self requestRecommandAllViewData:(self.isFirstLoad ? MPLoadingType_Normal : MPLoadingType_Refresh)];
}

- (void)MPPullRefreshDataSource {
    [self requestRecommandAllViewData:MPLoadingType_More];
}

#pragma mark - private methods
- (void)setupUI {
    self.listTableView = [MPBaseTableView setupListView];
    self.listTableView.tableDalegate = self;
    self.listTableView.tableDataSource = self;
    [self.listTableView registerClass:@"MPOnePicTableViewCell" forTableViewCellWithReuseIdentifier:RecommandOnePicCell withNibFile:YES];
    [self.listTableView registerClass:@"MPThreePicTableViewCell" forTableViewCellWithReuseIdentifier:RecommandThreePicCell withNibFile:YES];
    [self.listTableView registerClass:@"MPAdvertisingVideoTableViewCell" forTableViewCellWithReuseIdentifier:RecommandAdvertisingCell withNibFile:YES];
    [self addSubview:self.listTableView];
    self.isFirstLoad = YES;
}

- (void)requestRecommandAllViewData:(MPLoadingType)loadType {
    WeakSelf;
    [self.recommandVM MPRecommandArticleInfo:^(id  _Nonnull returnValue) {
        weakSelf.allArticleSource = (NSArray <MPRecommadAllConfigModel *>*)returnValue;
        weakSelf.listTableView.isCompleteRequest = YES;
        weakSelf.isFirstLoad = NO;
    } requestType:loadType articleType:MPRecommandArticleType_All];
}

#pragma mark - lazy
- (MPRecommandAllViewModel *)recommandVM {
    if (!_recommandVM) {
        _recommandVM = [[MPRecommandAllViewModel alloc] init];
    }
    return _recommandVM;
}

@end
