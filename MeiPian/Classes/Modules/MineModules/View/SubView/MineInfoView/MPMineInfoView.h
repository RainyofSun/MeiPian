//
//  MPMineInfoView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPMineInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMineInfoView : UIView

/** infoViewH */
@property (nonatomic,readonly) CGFloat infoViewH;
/** TopDistance */
@property (nonatomic,readonly) CGFloat TopDistance;

- (void)loadMineInfoSource:(MPMineInfoModel *)infoModel;
- (void)loadSliderBarSource:(NSArray <NSString *>*)sliderBarSource;
- (void)switchSliderbarSelectedItem:(NSNumber *)senderTag;

@end

NS_ASSUME_NONNULL_END
