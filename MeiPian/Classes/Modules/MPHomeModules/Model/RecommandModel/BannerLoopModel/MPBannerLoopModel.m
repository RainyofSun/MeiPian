//
//  MPBannerLoopModel.m
//  MeiPian
//
//  Created by 刘冉 on 2020/4/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBannerLoopModel.h"

@implementation MPBannerLoopModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"bannerID":@"id"};
}

@end
