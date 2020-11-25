//
//  MPPushMsgView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPPushMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPPushMsgView : UIView

- (void)loadPushMsgViewSource:(MPPushMessageModel *)modelSource;
- (void)cellAlphaAnimation;

@end

NS_ASSUME_NONNULL_END
