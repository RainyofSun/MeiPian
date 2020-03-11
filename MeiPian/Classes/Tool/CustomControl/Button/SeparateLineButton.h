//
//  SeparateLineButton.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    SeparateLineStyle_Normal,
    SeparateLineStyle_TopHidden,
    SeparateLineStyle_BottomHidden,
} SeparateLineStyle;

@interface SeparateLineButton : UIButton

/// 设置线条风格
- (void)setupLineStyle:(SeparateLineStyle)lineStyle;

@end

NS_ASSUME_NONNULL_END
