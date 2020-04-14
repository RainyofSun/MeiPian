//
//  MPBaseTabBarItem.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseTabBarItem.h"

// 角标的高度默认15号字体高度
static CGFloat bedgeH = 15;

@interface MPBaseTabBarItem ()

/** bedgeLab */
@property (nonatomic,strong) UILabel *bedgeLab;

@end

@implementation MPBaseTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
}

/*
 * 此方法实用性很强，可以得到动态预编译字符串宽高。
 */
- (CGFloat)widthOfString:(NSString *)string{
    NSDictionary *attributes = @{NSFontAttributeName : self.bedgeLab.font};     //字体属性，设置字体的font
    CGSize maxSize = CGSizeMake(MAXFLOAT, bedgeH);     //设置字符串的宽高  MAXFLOAT为最大宽度极限值  JPSlideBarHeight为固定高度
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(size.width);     //此方法结合  预编译字符串  字体font  字符串宽高  三个参数计算文本  返回字符串宽度
}

#pragma mark - setter
- (void)setBedgeNum:(NSInteger)bedgeNum {
    _bedgeNum = bedgeNum;
    if (bedgeNum <= 0) {
        return;
    }
    NSString *bedgeStr = [NSString stringWithFormat:@"%ld",bedgeNum];
    self.bedgeLab.font = [UIFont systemFontOfSize:13];
    self.bedgeLab.textColor = [UIColor whiteColor];
    self.bedgeLab.backgroundColor = [UIColor colorWithRed:251/255.0 green:69/255.0 blue:81/255.0 alpha:1];
    self.bedgeLab.layer.cornerRadius = bedgeH/2;
    self.bedgeLab.clipsToBounds = YES;
    self.bedgeLab.text = bedgeStr;
    self.bedgeLab.textAlignment = NSTextAlignmentCenter;
    CGFloat W = [self widthOfString:bedgeStr] + 10;
    W = W < bedgeH ? bedgeH : W;
    self.bedgeLab.frame = CGRectMake(CGRectGetWidth(self.bounds) - W * 1.07, 5, W, bedgeH);
    [self addSubview:self.bedgeLab];
}

#pragma mark - lazy
- (UILabel *)bedgeLab {
    if (!_bedgeLab) {
        _bedgeLab = [[UILabel alloc] init];
    }
    return _bedgeLab;
}

@end
