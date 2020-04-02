//
//  MPJingXuanConfigModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPJingXuanConfigModel.h"

@implementation MPJingXuanConfigModel

- (instancetype)init {
    if (self = [super init]) {
        self.isBrowse = NO;
    }
    return self;
}

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

- (UIColor *)textColor {
    return self.isBrowse ? HexColor(0x8E8E8F) : MAIN_BLACK_COLOR;
}

@end
