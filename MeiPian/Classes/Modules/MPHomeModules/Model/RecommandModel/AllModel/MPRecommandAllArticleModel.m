//
//  MPRecommandAllArticleModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommandAllArticleModel.h"

@implementation MPFeedTagInfoModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

@end

@implementation MPRecommandAllArticleModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"articleId":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"feed_tag_info":@"MPFeedTagInfoModel",
             };
}

#pragma mark - setter
- (void)setImage_count:(NSString *)image_count {
    image_count = [NSString stringWithFormat:@"%@图",image_count];
    _image_count = image_count;
}

- (void)setComment_count:(NSString *)comment_count {
    comment_count = [NSString stringWithFormat:@"%@评论",comment_count];
    _comment_count = comment_count;
}

@end
