//
//  UIViewController+VCJump.h
//  MeiPian
//
//  Created by 刘冉 on 2019/8/26.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (VCJump)

/// push
- (void)pushVC:(id _Nonnull)toVc;
/// present
- (void)presentVC:(id _Nonnull)toVc;
/// present Nav
- (void)presentNavVC:(id _Nonnull)navVc;

@end

NS_ASSUME_NONNULL_END
