//
//  MPMineNavTitleView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/22.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineNavTitleView.h"

@interface MPMineNavTitleView ()

/** headImgView */
@property (nonatomic,strong) UIImageView *headImgView;
/** userNameLab */
@property (nonatomic,strong) UILabel *userNameLab;

@end

@implementation MPMineNavTitleView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat headH = CGRectGetHeight(self.bounds) * 0.74;
    CGFloat topDis = CGRectGetHeight(self.bounds) * 0.13;
    
    self.headImgView.frame = CGRectMake(0, topDis, headH, headH);
    self.userNameLab.frame = CGRectMake(headH + 5, topDis, CGRectGetWidth(self.bounds) - CGRectGetHeight(self.bounds), headH);
    self.headImgView.layer.cornerRadius = headH/2;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)reloadUserHeadImg:(NSString *)userStr withUserName:(NSString *)userName {
    [self.headImgView MPSetImageWithURL:userStr];
    self.userNameLab.text = userName;
}

- (void)showNavTitleView:(CGFloat)alpha {
    self.alpha = alpha;
}

#pragma mark = private methods
- (void)setupUI {
    self.alpha = 0;
    
    self.headImgView = [[UIImageView alloc] init];
    self.headImgView.clipsToBounds = YES;
    
    self.userNameLab = [[UILabel alloc] init];
    self.userNameLab.font = [UIFont systemFontOfSize:15];
    self.userNameLab.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.headImgView];
    [self addSubview:self.userNameLab];
}

@end
