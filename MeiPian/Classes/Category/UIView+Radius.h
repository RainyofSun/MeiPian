//
//  UIView+Radius.h
//  MeiPian
//
//  Created by 刘冉 on 2019/9/11.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Radius)

/// 切割部分圆角
- (void)cutViewRoundingCorners:(UIRectCorner)corners radius:(CGFloat)ragius;
/// 切割部分圆角指定宽度
- (void)cutViewRoundingCorners:(UIRectCorner)corners viewWidth:(CGFloat)width radius:(CGFloat)ragius;

@end

NS_ASSUME_NONNULL_END
