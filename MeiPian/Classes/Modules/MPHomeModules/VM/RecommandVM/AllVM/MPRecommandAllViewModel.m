//
//  MPRecommandAllViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommandAllViewModel.h"

@interface MPRecommandAllViewModel ()

/** articleAllSource */
@property (nonatomic,strong) NSMutableArray <MPRecommadAllConfigModel *>*articleAllSource;

@end

@implementation MPRecommandAllViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.pageCount = 14;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 获取推荐信息
- (void)MPRecommandArticleInfo:(ReturnValueBlock)dataBlock requestType:(MPLoadingType)loadType articleType:(MPRecommandArticleType)type {
    NSInteger temPage = 0;
    if (loadType == MPLoadingType_Normal || loadType == MPLoadingType_Refresh) {
        temPage = self.page = 0;
    } else {
        temPage = self.page + 1;
        temPage = temPage >= MAXDATA ? 1 : temPage;
    }
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:[self requestHeader:temPage articleType:type] localData:^(id  _Nonnull responseObject) {
        NSArray <MPRecommandAllModel *>*allSource = [MPRecommandAllModel modelArrayWithDictArray:(NSArray *)responseObject];
        if (dataBlock) {
            dataBlock([weakSelf combineArticleAllDataSource:allSource loadType:loadType]);
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

#pragma mark - private methods
// 组合数据
- (NSArray <MPRecommadAllConfigModel *>*)combineArticleAllDataSource:(NSArray <MPRecommandAllModel *>*)modelSource loadType:(MPLoadingType)loadType{
    if (loadType == MPLoadingType_Normal || loadType == MPLoadingType_Refresh) {
        [self.articleAllSource removeAllObjects];
    }
    
    self.isResetNoMoreData = (modelSource.count < self.pageCount);
    for (MPRecommandAllModel *allModel in modelSource) {
        MPRecommadAllConfigModel *configModel = [[MPRecommadAllConfigModel alloc] init];
        configModel.recommandAllModel = allModel;
        switch (allModel.style.integerValue) {
            case 2:
                configModel.cellType    = RecommandAllArticleCellStyle_OnePic;
                configModel.cellHeight  = 200;
                [self.articleAllSource addObject:configModel];
                break;
            case 3:
                configModel.cellType    = RecommandAllArticleCellStyle_ThreePic;
                configModel.cellHeight  = 180;
                [self.articleAllSource addObject:configModel];
                break;
            default:
                break;
        }
    }
    
    if (loadType == MPLoadingType_Normal) {
        self.isListDataCompleted = YES;
    } else if (loadType == MPLoadingType_Refresh) {
        self.isPullRefreshComplted = YES;
    } else if (loadType == MPLoadingType_More) {
        self.page ++;
        self.isLoadMoreComplted = YES;
    }
    return [self.articleAllSource copy];
}

#pragma mark - lazy
- (NSMutableArray<MPRecommadAllConfigModel *> *)articleAllSource {
    if (!_articleAllSource) {
        _articleAllSource = [NSMutableArray array];
    }
    return _articleAllSource;
}

@end
