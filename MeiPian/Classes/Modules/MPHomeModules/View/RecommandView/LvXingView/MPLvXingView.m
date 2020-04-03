//
//  MPLvXingView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPLvXingView.h"

@implementation MPLvXingView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

@end
