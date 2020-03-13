//
//  MPSMSCodeView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPSMSCodeView : UIView

- (void)startCountDown:(NSInteger)time;
- (void)reloadTopTipText:(NSAttributedString *)phone;
- (void)resetNextBtnTitle:(NSString *)title;
- (void)addNotification;
- (void)removeNotification;

@end

NS_ASSUME_NONNULL_END
