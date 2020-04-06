//
//  MPTopicTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPTopicConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPTopicTableViewCell : UITableViewCell

- (void)loadTopicCellSource:(MPTopicConfigModel *)configSource;
- (void)cellAlphaAnimation;

@end

NS_ASSUME_NONNULL_END
