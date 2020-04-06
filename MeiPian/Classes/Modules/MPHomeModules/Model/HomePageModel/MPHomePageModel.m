//
//  MPHomePageModel.m
//  MeiPian
//
//  Created by 刘冉 on 2020/4/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPHomePageModel.h"

@implementation MPHomePageModel

- (void)deallo {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"pageID":@"id"};
}

@end
