//
//  MPMineCollectionView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineCollectionView.h"

@implementation MPMineCollectionView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor systemPinkColor];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

@end
