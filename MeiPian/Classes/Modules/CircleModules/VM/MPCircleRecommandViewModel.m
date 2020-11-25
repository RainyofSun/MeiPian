//
//  MPCircleRecommandViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCircleRecommandViewModel.h"
#import "MPCircleRecommandConfigModel.h"

@interface MPCircleRecommandViewModel ()

/** recommandSource */
@property (nonatomic,strong) NSMutableArray <MPCircleRecommandModel *>*recommandSource;

@end

@implementation MPCircleRecommandViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载推荐数据
- (void)MPCircleRecommandInfo:(ReturnValueBlock)dataBlock {
    WeakSelf;
    [MPLocalData MPGetLocalDataFileName:@"CircleRecommand" localData:^(id  _Nonnull responseObject) {
        MPCircleRecommandConfigModel *configModel = [MPCircleRecommandConfigModel modelWithDictionary:(NSDictionary *)responseObject];
        if (dataBlock) {
            dataBlock([weakSelf combineRecommandData:configModel]);
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

#pragma mark - private methods
- (NSArray <MPCircleRecommandModel *>*)combineRecommandData:(MPCircleRecommandConfigModel *)configModel {
    self.recommandSource = [NSMutableArray arrayWithArray:configModel.circles];
    MPCircleRecommandModel *tempModel = [[MPCircleRecommandModel alloc] init];
    tempModel.thumb_image = @"add_circle";
    tempModel.name = @"更多圈子";
    tempModel.bedge_image_url = @"";
    [self.recommandSource insertObject:tempModel atIndex:0];
    return [self.recommandSource copy];
}

@end
