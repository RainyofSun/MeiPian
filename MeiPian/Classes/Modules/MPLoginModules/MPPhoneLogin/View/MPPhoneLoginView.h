//
//  MPPhoneLoginView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPPhoneLoginView : UIView

- (void)reloadPhoneAreaCode:(NSString *)code;
- (NSString *)getPhoneNum;

@end

NS_ASSUME_NONNULL_END
