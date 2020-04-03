//
//  MPSheYingBannerLoopView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/2.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPSheYingBannerLoopView.h"

@implementation MPSheYingBannerLoopView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

@end
