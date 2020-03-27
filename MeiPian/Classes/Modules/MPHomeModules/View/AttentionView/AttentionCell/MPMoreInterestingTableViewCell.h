//
//  MPMoreInterestingTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAttentionModelConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMoreInterestingTableViewCell : UITableViewCell

- (void)loadFindMoreModel:(MPAttentionModelConfig *)modelSource;

@end

NS_ASSUME_NONNULL_END
