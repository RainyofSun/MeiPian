//
//  MPInterestTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPCircleInterestArticleConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPInterestTableViewCell : UITableViewCell

- (void)loadInterestCellSource:(MPCircleInterestArticleConfigModel *)modelSource;
- (void)cellAlphaAnimation;

@end

NS_ASSUME_NONNULL_END
