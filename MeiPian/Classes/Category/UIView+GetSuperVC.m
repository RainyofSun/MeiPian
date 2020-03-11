//
//  UIView+GetSuperVC.m
//  MeiPian
//
//  Created by 刘冉 on 2019/8/22.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import "UIView+GetSuperVC.h"

@implementation UIView (GetSuperVC)

- (UIViewController *)nearsetViewController {
    UIViewController *viewController = nil;
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController*)nextResponder;
            break;
        }
    }
    return viewController;
}

@end
