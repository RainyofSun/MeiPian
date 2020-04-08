//
//  MPCircleInterestArticleConfigModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCircleInterestArticleConfigModel.h"

@implementation MPCircleInterestArticleConfigModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"user":@"MPCircleInterestArticleAuthorModel",
             @"talk":@"MPCircleInterestArticleTalkModel",
    };
}

@end
