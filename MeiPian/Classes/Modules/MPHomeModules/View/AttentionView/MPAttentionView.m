//
//  MPAttentionView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAttentionView.h"

@implementation MPAttentionView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

@end
