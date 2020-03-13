//
//  UIButton+Timer.m
//  LEdulineliveStudent
//
//  Created by 刘冉 on 2018/7/6.
//  Copyright © 2018年 LRCY. All rights reserved.
//

#import "UIButton+Timer.h"
#import <objc/runtime.h>

static char *const normalTextKey    = "normalTextKey";
static char *const normalBgColorKey = "normalBgColorKey";
static char *const normalTextColorKey = "normalTextColorKey";
static char *const selectedTextKey  = "selectedTextKey";
static char *const selectedBgColorKey = "selectedBgColorKey";
static char *const selectedTextColorKey = "selectedTextColorKey";
static char *const GCDTimerKey      = "GCDTimerKey";

@interface UIButton ()

/** GCDTimer */
@property (nonatomic,strong) dispatch_source_t GCDTimer;

@end

@implementation UIButton (Timer)

- (void)timeCountDown:(NSInteger)countDownTime {
    __block NSInteger time = countDownTime;
    __block UIButton *verifybutton = self;
    verifybutton.enabled = NO;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.GCDTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.GCDTimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(self.GCDTimer, ^{
//        NSLog(@"当前线程 %@ time %ld",[NSThread currentThread],time);
        if(time<=0){ //倒计时结束，关闭
            dispatch_source_cancel(self.GCDTimer);
            self.GCDTimer = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self resetUIIsNormalOrDisabled:YES remainTime:0];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self resetUIIsNormalOrDisabled:NO remainTime:time];
            });
            time--;
        }
    });
    dispatch_resume(self.GCDTimer);
}

- (void)forceInvaildGCDTimer {
    if (self.GCDTimer) {
        long result = dispatch_source_testcancel(self.GCDTimer);
        if (result == 0) {
            dispatch_source_cancel(self.GCDTimer);
            self.GCDTimer = nil;
        } else {
            NSLog(@"定时器已取消");
        }
    } else {
        NSLog(@"定时器完成,已销毁");
    }
}

#pragma mark - private
- (void)resetUIIsNormalOrDisabled:(BOOL)abled remainTime:(NSInteger)time{
    if (abled) {
        // 按钮可用状态
        if (self.normalText.length) {
            [self setTitle:self.normalText forState:UIControlStateNormal];
        } else {
            [self setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
        }
        if (self.normalTextColor) {
            [self setTitleColor:self.normalTextColor forState:UIControlStateNormal];
        } else {
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        self.backgroundColor = self.normalBgColor;
        self.enabled = abled;
    } else {
        // 按钮不可用状态
        if (self.selectedText.length) {
            [self setTitle:[NSString stringWithFormat:@"%lds%@",time,self.selectedText] forState:UIControlStateNormal];
        } else {
            [self setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
        }
        if (self.selectedTextColor) {
            [self setTitleColor:self.selectedTextColor forState:UIControlStateNormal];
        } else {
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        self.backgroundColor = self.selectedBgColor;
    }
}

- (NSString *)combineString:(NSInteger)time {
    if ([self.selectedText containsString:@"()"]) {
        NSMutableString *str = [[NSMutableString alloc] initWithString:self.selectedText];
        NSRange range = [str rangeOfString:@"("];
        if (range.location != NSNotFound) {
            [str insertString:[NSString stringWithFormat:@"%lds",time] atIndex:(range.location + 1)];
        }
        return [str copy];
    } else {
        NSLog(@"文字不符合规范");
        return @"";
    }
}

#pragma mark - Setter & Getter functions
- (NSString *)normalText {
    return objc_getAssociatedObject(self, normalTextKey);
}

- (UIColor *)normalTextColor {
    return objc_getAssociatedObject(self, normalTextColorKey);
}

- (UIColor *)normalBgColor {
    return objc_getAssociatedObject(self, normalBgColorKey);
}

- (NSString *)selectedText {
    return objc_getAssociatedObject(self, selectedTextKey);
}

- (UIColor *)selectedTextColor {
    return objc_getAssociatedObject(self, selectedTextColorKey);
}

- (UIColor *)selectedBgColor {
    return objc_getAssociatedObject(self, selectedBgColorKey);
}

- (dispatch_source_t)GCDTimer {
    return objc_getAssociatedObject(self, GCDTimerKey);
}

/*
 OBJC_ASSOCIATION_ASSIGN 等价于 @property(assign)。
 OBJC_ASSOCIATION_RETAIN_NONATOMIC等价于 @property(strong, nonatomic)。
 OBJC_ASSOCIATION_COPY_NONATOMIC等价于@property(copy, nonatomic)。
 OBJC_ASSOCIATION_RETAIN等价于@property(strong,atomic)。
 OBJC_ASSOCIATION_COPY等价于@property(copy, atomic)。
 */
- (void)setNormalText:(NSString *)normalText {
    objc_setAssociatedObject(self, normalTextKey, normalText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNormalTextColor:(UIColor *)normalTextColor {
    objc_setAssociatedObject(self, normalTextColorKey, normalTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNormalBgColor:(UIColor *)normalBgColor {
    objc_setAssociatedObject(self, normalBgColorKey, normalBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSelectedText:(NSString *)selectedText {
    objc_setAssociatedObject(self, selectedTextKey, selectedText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor {
    objc_setAssociatedObject(self, selectedTextColorKey, selectedTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setSelectedBgColor:(UIColor *)selectedBgColor {
    objc_setAssociatedObject(self, selectedBgColorKey, selectedBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setGCDTimer:(dispatch_source_t)GCDTimer {
    objc_setAssociatedObject(self, GCDTimerKey, GCDTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
