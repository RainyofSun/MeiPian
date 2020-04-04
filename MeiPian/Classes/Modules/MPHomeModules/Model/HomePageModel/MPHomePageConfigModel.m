//
//  MPHomePageConfigModel.m
//  MeiPian
//
//  Created by 刘冉 on 2020/4/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPHomePageConfigModel.h"

@implementation MPHomePageConfigModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"main_channel":@"MPHomePageModel",
             @"sub_channel":@"MPHomePageModel",
             };
}

@end
