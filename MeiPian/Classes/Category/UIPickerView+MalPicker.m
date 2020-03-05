//
//  UIPickerView+MalPicker.m
//  YiZhan
//
//  Created by 刘冉 on 2020/2/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "UIPickerView+MalPicker.h"

@implementation UIPickerView (MalPicker)

- (void)clearSpearatorLine {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height < 1) {
            [obj setBackgroundColor:[UIColor clearColor]];
        }
    }];
}

@end
