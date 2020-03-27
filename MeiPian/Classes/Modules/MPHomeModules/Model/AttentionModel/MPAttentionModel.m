//
//  MPAttentionModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAttentionModel.h"

@implementation MPAttentionModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"find_more":@"MPFindMoreModel",
             @"interest_users":@"MPInterestUsersModel",
             };
}

@end
