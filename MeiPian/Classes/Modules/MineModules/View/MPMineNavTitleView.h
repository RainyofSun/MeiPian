//
//  MPMineNavTitleView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/22.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPMineNavTitleView : UIView

- (void)reloadUserHeadImg:(NSString *)userStr withUserName:(NSString *)userName;
- (void)showNavTitleView:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
