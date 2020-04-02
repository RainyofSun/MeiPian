//
//  MPJingXuanViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPJingXuanViewModel.h"

@interface MPJingXuanViewModel ()

/** articleDataSource */
@property (nonatomic,strong) NSMutableArray <MPJingXuanConfigModel *>*articleDataSource;

@end

@implementation MPJingXuanViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.pageCount = 12;
    }
    return self;
}


- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
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
        NSArray <MPJingXuanConfigModel *>*allSource = [MPJingXuanConfigModel modelArrayWithDictArray:(NSArray *)responseObject];
        if (dataBlock) {
            dataBlock([weakSelf combineArticleJXDataSource:allSource loadType:loadType]);
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

// 修改model颜色数据
- (MPJingXuanConfigModel *)modifyJingXuanModelData:(NSInteger)index {
    self.articleDataSource[index].isBrowse = YES;
    return self.articleDataSource[index];
}

#pragma mark - private methods
- (NSArray <MPJingXuanConfigModel *>*)combineArticleJXDataSource:(NSArray <MPJingXuanConfigModel *>*)modelSource loadType:(MPLoadingType)loadType {
    if (loadType == MPLoadingType_Normal || loadType == MPLoadingType_Refresh) {
        [self.articleDataSource removeAllObjects];
    }
      
    [self.articleDataSource addObjectsFromArray:modelSource];
    
    self.isResetNoMoreData = (modelSource.count < self.pageCount);
    if (loadType == MPLoadingType_Normal) {
        self.isListDataCompleted = YES;
    } else if (loadType == MPLoadingType_Refresh) {
        self.isPullRefreshComplted = YES;
    } else if (loadType == MPLoadingType_More) {
        self.page ++;
        self.isLoadMoreComplted = YES;
    }
    return [self.articleDataSource copy];
}

#pragma mark - lazy
- (NSMutableArray<MPJingXuanConfigModel *> *)articleDataSource {
    if (!_articleDataSource) {
        _articleDataSource = [NSMutableArray array];
    }
    return _articleDataSource;
}

@end
