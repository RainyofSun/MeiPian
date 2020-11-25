//
//  MPMessageTypeBtn.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMessageTypeBtn.h"

@implementation MPMessageTypeBtn

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(CGRectGetWidth(self.bounds) * 0.3, CGRectGetHeight(self.bounds) * 0.25, CGRectGetWidth(self.bounds) * 0.4, CGRectGetWidth(self.bounds) * 0.4);
    self.titleLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 40, CGRectGetWidth(self.bounds), 30);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

@end
