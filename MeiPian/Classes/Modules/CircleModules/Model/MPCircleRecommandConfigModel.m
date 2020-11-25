//
//  MPCircleRecommandConfigModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCircleRecommandConfigModel.h"

@implementation MPCircleRecommandModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"recommandID":@"id",
             @"notice":@"new_notice",
    };
}

@end

@implementation MPCircleRecommandConfigModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"circles":@"MPCircleRecommandModel",
             };
}

@end
