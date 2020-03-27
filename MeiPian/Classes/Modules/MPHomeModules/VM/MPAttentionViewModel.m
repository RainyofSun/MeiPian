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
@property (nonatomic,strong) NSMutableArray *attentionSource;
/** usersArray */
@property (nonatomic,strong) NSMutableArray <MPInterestUsersModel *>*usersArray;

@end

@implementation MPAttentionViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)MPAttentionPeopleInfo:(ReturnValueBlock)dataBlock {
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:@"Attention0" localData:^(id  _Nonnull responseObject) {
        MPAttentionModel *attentionModel = [MPAttentionModel modelWithDictionary:(NSDictionary *)responseObject];
        if (dataBlock) {
            dataBlock([weakSelf combineAttentionData:attentionModel]);
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

#pragma mark - private methods
- (NSArray <MPAttentionModelConfig *>*)combineAttentionData:(MPAttentionModel *)attentionModel {
    
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
    
    for (MPInterestUsersModel *userModel in attentionModel.interest_users) {
        MPAttentionModelConfig *model3 = [[MPAttentionModelConfig alloc] init];
        model3.interestUsers    = userModel;
        model3.cellHeight       = 85;
        model3.cellType         = MPAttentionCellStyle_People;
        [self.attentionSource addObject:model3];
    }
    
    return [self.attentionSource copy];
}

#pragma mark - lazy
- (NSMutableArray *)attentionSource {
    if (!_attentionSource) {
        _attentionSource = [NSMutableArray array];
    }
    return _attentionSource;
}

- (NSMutableArray<MPInterestUsersModel *> *)usersArray {
    if (!_usersArray) {
        _usersArray = [NSMutableArray array];
    }
    return _usersArray;
}

@end
