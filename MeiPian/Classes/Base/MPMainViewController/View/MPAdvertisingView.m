//
//  MPAdvertisingView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAdvertisingView.h"

@interface MPAdvertisingView ()

/** adImgView */
@property (nonatomic,strong) UIButton *adImgBtn;
/** logoImgView */
@property (nonatomic,strong) UIImageView *logoImgView;
/** skipBtn */
@property (nonatomic,strong) UIButton *skipBtn;

@end

@implementation MPAdvertisingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.adImgBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.adImgBtn autoSetDimension:ALDimensionHeight toSize:(ScreenHeight * 0.8)];
    
    [self.logoImgView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.logoImgView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.adImgBtn withOffset:50];
    
    [self.skipBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:kStatusBarHeight];
    [self.skipBtn autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self withOffset:-15];
    [self.skipBtn autoSetDimensionsToSize:CGSizeMake(80, 30)];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 更新倒计时文字
- (void)updateTimeBtnAttributeTitle:(NSAttributedString *)attributeTitle {
    [self.skipBtn setAttributedTitle:attributeTitle forState:UIControlStateNormal];
}

// 加载广告图片
- (void)loadADPic:(UIImage *)adImg {
    [self.adImgBtn setBackgroundImage:adImg forState:UIControlStateNormal];
}

- (void)disappearADView {
    [self disADView:self.skipBtn];
}

- (void)disADView:(UIButton *)sender {
    if (self.adDisBlock) {
        self.adDisBlock(sender.tag);
    }
}

#pragma mark - private methods
- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.skipBtn setBackgroundColor:RGB(86, 87, 89)];
    self.skipBtn.layer.cornerRadius = 15.f;
    self.skipBtn.clipsToBounds = YES;
    
    self.skipBtn.tag = 0;
    self.adImgBtn.tag = 1;
    
    [self.skipBtn addTarget:self action:@selector(disADView:) forControlEvents:UIControlEventTouchUpInside];
    [self.adImgBtn addTarget:self action:@selector(disADView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.adImgBtn];
    [self addSubview:self.logoImgView];
    [self addSubview:self.skipBtn];
}

#pragma mark - lazy
- (UIButton *)adImgBtn {
    if (!_adImgBtn) {
        _adImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _adImgBtn;
}

- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_login_logo"]];
    }
    return _logoImgView;
}

- (UIButton *)skipBtn {
    if (!_skipBtn) {
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _skipBtn;
}

@end
