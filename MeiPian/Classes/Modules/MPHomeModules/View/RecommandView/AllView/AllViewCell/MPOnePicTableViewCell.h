//
//  MPOnePicTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPRecommadAllConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPOnePicTableViewCell : UITableViewCell

- (void)loadOnePicArticleDataSource:(MPRecommadAllConfigModel *)articleSource;
- (void)cellAlphaAnimation;

@end

NS_ASSUME_NONNULL_END
