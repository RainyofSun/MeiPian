//
//  MPSheYingArticleTypeViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPSheYingArticleTypeViewModel.h"

@implementation MPSheYingArticleTypeViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)MPSheYingArticleTypeInfo:(ReturnValueBlock)dataBlock {
    [MPLocalData MPGetLocalDataFileName:@"ArticleType" localData:^(id  _Nonnull responseObject) {
        if (dataBlock) {
            dataBlock([MPSheYingArticleTypeConfigModel modelArrayWithDictArray:(NSArray *)responseObject]);
        }
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

@end
