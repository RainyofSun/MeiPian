//
//  MPJingXuanConfigModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPJingXuanConfigModel.h"

@implementation MPJingXuanConfigModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"article":@"MPRecommandAllArticleModel",
             @"author":@"MPArticleAuthorModel",
             };
}

#pragma mark - getter
- (NSString *)commentsText {
    if (self.article.visit_count) {
        NSString *tempStr0 = [NSString stringWithFormat:@"%@阅读",self.article.visit_count];
        if (self.article.comment_count) {
            NSString *tempStr1 = [NSString stringWithFormat:@"%@评论",self.article.comment_count];
            return [NSString stringWithFormat:@"%@      %@",tempStr0,tempStr1];
        } else {
            return tempStr0;
        }
    } else {
        return @"";
    }
}

@end
