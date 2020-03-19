//
//  MPPageControlSliderBar.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPPageControlSliderBar : UIView

- (void)loadSliderBarTitleSource:(NSArray <NSString *>*)titleSource;
/// line动画
- (void)lineAnimation:(NSInteger)senderTag;

@end

NS_ASSUME_NONNULL_END
