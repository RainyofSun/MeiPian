//
//  MPTopicViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPTopicViewModel.h"

@implementation MPTopicViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)MPTopicArticleInfo:(ReturnValueBlock)dataBlock requestType:(MPLoadingType)loadType {
    [MPLocalData MPGetLocalDataFileName:@"Topic0" localData:^(id  _Nonnull responseObject) {
        if (dataBlock) {
            dataBlock([MPTopicConfigModel modelArrayWithDictArray:(NSArray *)responseObject]);
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

@end
