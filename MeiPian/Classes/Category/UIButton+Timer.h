//
//  UIButton+Timer.h
//  LEdulineliveStudent
//
//  Created by 刘冉 on 2018/7/6.
//  Copyright © 2018年 LRCY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Timer)

/** normalText */
@property (nonatomic,strong) NSString *normalText;
/** normalTextColor */
@property (nonatomic,strong) UIColor *normalTextColor;
/** normalBgColor */
@property (nonatomic,strong) UIColor *normalBgColor;
/** selectedText */
@property (nonatomic,strong) NSString *selectedText;
/** selectedTextColor */
@property (nonatomic,strong) UIColor *selectedTextColor;
/** selectedBgColor */
@property (nonatomic,strong) UIColor *selectedBgColor;

/// 60s倒计时
- (void)timeCountDown:(NSInteger)countDownTime;
/// 停止计时器
- (void)forceInvaildGCDTimer;

@end
