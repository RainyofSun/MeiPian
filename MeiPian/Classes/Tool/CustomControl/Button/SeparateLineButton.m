//
//  SeparateLineButton.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "SeparateLineButton.h"

static CGFloat lineH = 0.5;

@interface SeparateLineButton ()

/** topLineLayer */
@property (nonatomic,strong) CALayer *topLineLayer;
/** bottomLineLayer */
@property (nonatomic,strong) CALayer *bottomLineLayer;

@end

@implementation SeparateLineButton

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

// 设置线条风格
- (void)setupLineStyle:(SeparateLineStyle)lineStyle {
    switch (lineStyle) {
        case SeparateLineStyle_Normal:
            [self addTopLine];
            [self addBottomLine];
            break;
        case SeparateLineStyle_TopHidden:
            [self addBottomLine];
            break;
        case SeparateLineStyle_BottomHidden:
            [self addTopLine];
            break;
        default:
            break;
    }
}

- (void)addTopLine {
    self.topLineLayer.backgroundColor = RGB(245, 245, 249).CGColor;
    [self.layer addSublayer:self.topLineLayer];
    self.topLineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), lineH);
}

- (void)addBottomLine {
    self.bottomLineLayer.backgroundColor = RGB(245, 245, 249).CGColor;
    [self.layer addSublayer:self.bottomLineLayer];
    self.bottomLineLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - lineH, CGRectGetWidth(self.bounds), lineH);
}

#pragma mark - lazy
- (CALayer *)topLineLayer {
    if (!_topLineLayer) {
        _topLineLayer = [CALayer layer];
    }
    return _topLineLayer;
}

- (CALayer *)bottomLineLayer {
    if (!_bottomLineLayer) {
        _bottomLineLayer = [CALayer layer];
    }
    return _bottomLineLayer;
}

@end
