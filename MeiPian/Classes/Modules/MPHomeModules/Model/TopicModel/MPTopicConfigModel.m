//
//  MPTopicConfigModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPTopicConfigModel.h"

@implementation MPTopicConfigModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"topicID":@"id",
             @"descriptionStr":@"description",
    };
}

#pragma mark - setter
- (void)setArticle_count:(NSString *)article_count {
    article_count = [article_count stringByAppendingString:@"篇作品"];
    _article_count = article_count;
}

@end
