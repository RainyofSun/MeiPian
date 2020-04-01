//
//  MPAutoFooter.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAutoFooter.h"

@implementation MPAutoFooter

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)prepare {
    [super prepare];
    self.backgroundColor = MAIN_LIGHT_GRAY_COLOR;
}

@end
