//
//  MPAttentionViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAttentionViewModel.h"
#import "MPAttentionModel.h"
#import "MPAttentionModelConfig.h"

@interface MPAttentionViewModel ()

/** attentionSource */
@property (nonatomic,strong) NSMutableArray <MPAttentionModelConfig *>*attentionSource;

@end

@implementation MPAttentionViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)MPAttentionPeopleInfo:(ReturnValueBlock)dataBlock requestType:(MPLoadingType)loadType{
    NSInteger temPage = 0;
    if (loadType == MPLoadingType_Normal || loadType == MPLoadingType_Refresh) {
        temPage = self.page = 0;
    } else {
        temPage = self.page + 1;
        temPage = temPage >= MAXDATA ? 1 : temPage;
    }
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:[NSString stringWithFormat:@"Attention%ld",(long)temPage] localData:^(id  _Nonnull responseObject) {
        MPAttentionModel *attentionModel = [MPAttentionModel modelWithDictionary:(NSDictionary *)responseObject];
        if (dataBlock) {
            dataBlock([weakSelf combineAttentionData:attentionModel requestType:loadType]);
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

#pragma mark - private methods
- (NSArray <MPAttentionModelConfig *>*)combineAttentionData:(MPAttentionModel *)attentionModel requestType:(MPLoadingType)loadType{

    if (loadType == MPLoadingType_Refresh || loadType == MPLoadingType_Normal) {
        [self.attentionSource removeAllObjects];
        MPAttentionModelConfig *model0 = [[MPAttentionModelConfig alloc] init];
        attentionModel.find_more.images = [[attentionModel.find_more.images reverseObjectEnumerator] allObjects];
        model0.findMore     = attentionModel.find_more;
        model0.cellHeight   = 80;
        model0.cellType     = MPAttentionCellStyle_MorePeople;
        [self.attentionSource addObject:model0];
        
        MPAttentionModelConfig *model1 = [[MPAttentionModelConfig alloc] init];
        model1.cellHeight   = 30;
        model1.cellType     = MPAttentionCellStyle_TopTip;
        [self.attentionSource addObject:model1];
    }
    
    NSArray <MPInterestUsersModel *>*tempUsersArray = attentionModel.interest_users;
    self.isResetNoMoreData = (tempUsersArray.count < self.pageCount);
    if (loadType == MPLoadingType_Normal) {
        // 首次加载
        for (MPInterestUsersModel *userModel in tempUsersArray) {
            MPAttentionModelConfig *model3 = [[MPAttentionModelConfig alloc] init];
            model3.interestUsers    = userModel;
            model3.cellHeight       = 85;
            model3.cellType         = MPAttentionCellStyle_People;
            [self.attentionSource addObject:model3];
        }
        self.isListDataCompleted = YES;
    } else if (loadType == MPLoadingType_Refresh) {
        // 下拉刷新
        for (MPInterestUsersModel *userModel in tempUsersArray) {
            MPAttentionModelConfig *model3 = [[MPAttentionModelConfig alloc] init];
            model3.interestUsers    = userModel;
            model3.cellHeight       = 85;
            model3.cellType         = MPAttentionCellStyle_People;
            [self.attentionSource addObject:model3];
        }
        self.isPullRefreshComplted = YES;
    } else if (loadType == MPLoadingType_More) {
        // 上拉加载
        for (MPInterestUsersModel *userModel in tempUsersArray) {
            MPAttentionModelConfig *model3 = [[MPAttentionModelConfig alloc] init];
            model3.interestUsers    = userModel;
            model3.cellHeight       = 85;
            model3.cellType         = MPAttentionCellStyle_People;
            [self.attentionSource addObject:model3];
        }
        self.isLoadMoreComplted = YES;
        self.page ++;
    }
    
    return [self.attentionSource copy];
}

#pragma mark - lazy
- (NSMutableArray<MPAttentionModelConfig *> *)attentionSource {
    if (!_attentionSource) {
        _attentionSource = [NSMutableArray array];
    }
    return _attentionSource;
}

@end
