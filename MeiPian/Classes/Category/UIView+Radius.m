//
//  UIView+Radius.m
//  MeiPian
//
//  Created by 刘冉 on 2019/9/11.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import "UIView+Radius.h"

@implementation UIView (Radius)

- (void)cutViewRoundingCorners:(UIRectCorner)corners viewWidth:(CGFloat)width radius:(CGFloat)ragius {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, CGRectGetHeight(self.bounds)) byRoundingCorners:corners cornerRadii:CGSizeMake(ragius, ragius)];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = bezierPath.CGPath;
    self.layer.mask = shapeLayer;
}

- (void)cutViewRoundingCorners:(UIRectCorner)corners radius:(CGFloat)ragius{
    [self cutViewRoundingCorners:corners viewWidth:CGRectGetWidth(self.bounds) radius:ragius];
}

@end
