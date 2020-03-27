//
//  MPInterestUsersModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPInterestUsersModel.h"

@implementation MPInterestUsersModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"peopleID":@"id"};
}

@end
