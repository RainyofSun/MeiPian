//
//  MPNewPWDView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPNewPWDView : UIView

- (void)loadTopTipAttributeText:(NSAttributedString *)attributeText;
- (NSString *)getNewPWD;

@end

NS_ASSUME_NONNULL_END
