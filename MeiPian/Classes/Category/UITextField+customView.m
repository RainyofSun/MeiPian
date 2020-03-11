//
//  UITextField+customView.m
//  MeiPian
//
//  Created by 刘冉 on 2019/8/22.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import "UITextField+customView.h"

@implementation UITextField (customView)

- (void)createLeftV:(NSString *)imageName{
    UIImage *leftImg        = [UIImage imageNamed:imageName];
    UIView *leftV           = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 48, 40)];
    UIImageView *leftImgView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, leftImg.size.width, leftImg.size.height)];
    leftImgView.center      = leftV.center;
    leftImgView.image       = leftImg;
    [leftV addSubview:leftImgView];
    self.leftView           = leftV;
    self.leftViewMode       = UITextFieldViewModeAlways;
}

- (void)createRightV:(NSString *)imgName selectedName:(NSString *)selectName target:(id)target action:(SEL)sel{
    UIImage *btnImg         = [UIImage imageNamed:imgName];
    UIView *rightV          = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 48, 40)];
    CGFloat btnW            = btnImg.size.width < 20 ? 20 : btnImg.size.width;
    UIButton *rightBtn      = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnW, btnW)];
    rightBtn.center         = rightV.center;
    [rightBtn setImage:btnImg forState:UIControlStateNormal];
    if (selectName.length) {
        [rightBtn setImage:[UIImage imageNamed:selectName] forState:UIControlStateSelected];
    }
    [rightBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [rightV addSubview:rightBtn];
    self.rightView          = rightV;
    self.rightViewMode      = UITextFieldViewModeAlways;
}

- (void)createLeftLab:(NSString *)text textColor:(UIColor *)tColor textFont:(UIFont *)tF{
    UIView *leftV           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    UILabel *leftLabel      = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, CGRectGetWidth(leftV.bounds) - 8, 40)];
    leftLabel.textColor     = [UIColor colorWithRed:135/255.0 green:95/255.0 blue:20/255.0 alpha:1];
    leftLabel.text          = text;
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.textColor     = tColor;
    leftLabel.font          = tF;
    [leftV addSubview:leftLabel];
    self.leftView           = leftV;
    self.leftViewMode       = UITextFieldViewModeAlways;
}

- (void)createRightVTarget:(id)target action:(SEL)sel{
    UIView *rightV          = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, CGRectGetHeight(self.bounds)/3*2)];
    UIButton *rightBtn      = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, CGRectGetHeight(rightV.bounds))];
    [rightBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightBtn setTitleColor:MAIN_BLUE_COLOR forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:[UIColor whiteColor]];
    rightBtn.titleLabel.font    = [UIFont systemFontOfSize:13];
    rightBtn.layer.borderColor = MAIN_BLUE_COLOR.CGColor;
    rightBtn.layer.borderWidth = 1.f;
    [rightBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [rightV addSubview:rightBtn];
    self.rightView          = rightV;
    self.rightViewMode      = UITextFieldViewModeAlways;
}

- (void)createRightCustomView:(UIView *)customView {
    UIView *rightV          = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(customView.bounds), CGRectGetHeight(self.bounds))];
    [rightV addSubview:customView];
    self.rightView = rightV;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)createLeftCustomView:(UIView *)customView {
    UIView *rightV          = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(customView.bounds), CGRectGetHeight(self.bounds))];
    [rightV addSubview:customView];
    self.leftView = rightV;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)createLeftEmptyView:(CGFloat)viewW {
    UIView *leftV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, CGRectGetHeight(self.bounds))];
    leftV.backgroundColor = [UIColor clearColor];
    self.leftView = leftV;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
