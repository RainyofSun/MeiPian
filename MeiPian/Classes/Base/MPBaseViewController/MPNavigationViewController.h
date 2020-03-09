//
//  MPNavigationViewController.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPNavigationViewController : UINavigationController

- (void)setOrientationMask:(UIInterfaceOrientationMask)orientationMask preferredInterfaceOrientation:(UIInterfaceOrientation)preferredInterfaceOrientation;

@end

NS_ASSUME_NONNULL_END
