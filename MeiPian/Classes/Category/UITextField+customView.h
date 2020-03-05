//
//  UITextField+customView.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/22.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (customView)

///添加文本框左视图图片
- (void)createLeftV:(NSString *)imageName;
///添加文本框右视图图片
- (void)createRightV:(NSString *)imgName selectedName:(NSString *)selectName target:(id)target action:(SEL)sel;
///添加文本框左视图文字
- (void)createLeftLab:(NSString *)text textColor:(UIColor *)tColor textFont:(UIFont *)tF;
///添加右边视图按钮
- (void)createRightVTarget:(id)target action:(SEL)sel;
///添加自定义右视图
- (void)createRightCustomView:(UIView *)customView;

@end

NS_ASSUME_NONNULL_END
