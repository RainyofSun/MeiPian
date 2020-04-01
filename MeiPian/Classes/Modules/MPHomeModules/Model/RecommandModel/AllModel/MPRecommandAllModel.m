//
//  MPRecommandAllModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommandAllModel.h"

@implementation MPRecommandAllModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"article":@"MPRecommandAllArticleModel",
             @"author":@"MPArticleAuthorModel",
             @"uninterest_option":@"MPArticleOptionModel",
             };
}

@end
