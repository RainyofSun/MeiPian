//
//  MPMineWorksModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineWorksModel.h"

@implementation MPMineWorksModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"workID":@"id",
    };
}

#pragma mark - getter
- (NSString *)articleTime {
    return [self timestampSwitchTime:self.create_time.integerValue andFormatter:@"YYYY-MM-dd"];
}

- (NSString *)comments {
    return [NSString stringWithFormat:@"%@ 阅读   %@ 评论   %@ 点赞",self.visit_count,self.comment_count,self.praise_count];
}

@end
