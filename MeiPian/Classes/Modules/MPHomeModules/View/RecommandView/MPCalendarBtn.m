//
//  MPCalendarBtn.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCalendarBtn.h"

@interface MPCalendarBtn ()

/** calendarImgView */
@property (nonatomic,strong) UIImageView *calendarImgView;
/** redPointLayer */
@property (nonatomic,strong) CALayer *redPointLayer;

@end

@implementation MPCalendarBtn

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat W = CGRectGetWidth(self.bounds) * 0.6;
    [self.calendarImgView autoCenterInSuperview];
    [self.calendarImgView autoSetDimensionsToSize:CGSizeMake(W, W)];
    self.redPointLayer.frame = CGRectMake(W - 4, 0, 8, 8);
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)setupUI {
    self.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    [self setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.redPointLayer.backgroundColor = RGB(242, 109, 65).CGColor;
    self.redPointLayer.cornerRadius = 4.f;
    self.redPointLayer.masksToBounds = YES;
    
    [self addSubview:self.calendarImgView];
    [self.calendarImgView.layer addSublayer:self.redPointLayer];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.redPointLayer.hidden = selected;
}

#pragma mark - lazy
- (UIImageView *)calendarImgView {
    if (!_calendarImgView) {
        _calendarImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calendar"]];
    }
    return _calendarImgView;
}

- (CALayer *)redPointLayer {
    if (!_redPointLayer) {
        _redPointLayer = [CALayer layer];
    }
    return _redPointLayer;
}

@end
