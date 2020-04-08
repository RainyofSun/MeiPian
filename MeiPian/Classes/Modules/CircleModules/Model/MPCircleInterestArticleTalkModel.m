//
//  MPCircleInterestArticleTalkModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCircleInterestArticleTalkModel.h"

@implementation MPCircleInterestArticleTalkModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"talkID":@"id"};
}

@end
