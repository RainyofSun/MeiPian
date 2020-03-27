//
//  MPInterestingPeopleTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAttentionModelConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPInterestingTipCell : UITableViewCell

@end

@interface MPInterestingPeopleTableViewCell : UITableViewCell

- (void)loadInterestUsersInfo:(MPAttentionModelConfig *)userInfo;

@end

NS_ASSUME_NONNULL_END
