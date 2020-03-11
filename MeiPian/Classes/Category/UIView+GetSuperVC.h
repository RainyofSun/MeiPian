//
//  UIView+GetSuperVC.h
//  MeiPian
//
//  Created by 刘冉 on 2019/8/22.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GetSuperVC)

/// 获取父 viewController
- (UIViewController *)nearsetViewController;

@end

NS_ASSUME_NONNULL_END
