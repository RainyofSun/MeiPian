//
//  MPMineSliderBarView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPMineSliderBarView : UIView

- (void)loadSliderBarTitleSource:(NSArray <NSString *>*)titleSource;
- (void)switchSliderBarSlectedItem:(NSNumber *)senderTag;

@end

NS_ASSUME_NONNULL_END
