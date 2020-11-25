//
//  MPCircleInterestViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCircleInterestViewModel.h"
#import "MPCircleInterestArticleConfigModel.h"

@interface MPCircleInterestViewModel ()

/** interestSource */
@property (nonatomic,strong) NSMutableArray <MPCircleInterestArticleConfigModel *>*interestSource;

@end

@implementation MPCircleInterestViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.pageCount = 8;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - 获取感兴趣文章数据
- (void)MPInterestArticleInfo:(ReturnValueBlock)dataBlock loadType:(MPLoadingType)loadType {
    NSInteger temPage = 0;
    if (loadType == MPLoadingType_Normal || loadType == MPLoadingType_Refresh) {
        temPage = self.page = 0;
    } else {
        temPage = self.page + 1;
        temPage = temPage >= MAXDATA ? 1 : temPage;
    }
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:[NSString stringWithFormat:@"CircleHomeTalks%ld",temPage] localData:^(id  _Nonnull responseObject) {
        NSArray <MPCircleInterestArticleConfigModel *>*allSource = [MPCircleInterestArticleConfigModel modelArrayWithDictArray:(NSArray *)responseObject];
        if (dataBlock) {
            dataBlock([weakSelf combineArticleDataSource:allSource loadType:loadType]);
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

#pragma mark - private methods
- (NSArray <MPCircleInterestArticleConfigModel *>*)combineArticleDataSource:(NSArray <MPCircleInterestArticleConfigModel *>*)dataSource loadType:(MPLoadingType)loadType {
    if (loadType == MPLoadingType_Normal || loadType == MPLoadingType_Refresh) {
        [self.interestSource removeAllObjects];
    }
    for (MPCircleInterestArticleConfigModel *configModel in dataSource) {
        configModel.talk.summary = [NSString stringWithFormat:@"%@ 阅读  %@评论  %@ 点赞",configModel.talk.visit_count.stringValue,
                                    configModel.talk.comment_count.stringValue,configModel.talk.praise_count.stringValue];
    }
    [self.interestSource addObjectsFromArray:dataSource];
    self.isResetNoMoreData = (dataSource.count < self.pageCount);
    if (loadType == MPLoadingType_Normal) {
        self.isListDataCompleted = YES;
    } else if (loadType == MPLoadingType_Refresh) {
        self.isPullRefreshComplted = YES;
    } else if (loadType == MPLoadingType_More) {
        self.page ++;
        self.isLoadMoreComplted = YES;
    }
    return [self.interestSource copy];
}

#pragma mark - lazy
- (NSMutableArray<MPCircleInterestArticleConfigModel *> *)interestSource {
    if (!_interestSource) {
        _interestSource = [NSMutableArray array];
    }
    return _interestSource;
}

@end
