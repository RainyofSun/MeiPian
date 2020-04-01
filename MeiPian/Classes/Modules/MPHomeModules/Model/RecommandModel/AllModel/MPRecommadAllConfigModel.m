//
//  MPRecommadAllConfigModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommadAllConfigModel.h"

@implementation MPRecommadAllConfigModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - getter
- (CGFloat)imgCountW {
    if (self.recommandAllModel.article.image_count.length) {
        return [self.recommandAllModel.article.image_count widthForFont:[UIFont systemFontOfSize:13]] + 25;
    }
    return 0;
}

- (CGFloat)articleTypeBtnW {
    if (self.recommandAllModel.article.feed_tag_info.tag_name.length) {
        return [self.recommandAllModel.article.feed_tag_info.tag_name widthForFont:[UIFont systemFontOfSize:13]] + 25;
    }
    return 0;
}

@end
