//
//  MPMineArticleTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPMineArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMineArticleTableViewCell : UITableViewCell

- (void)loadMineArticleSource:(MPMineArticleModel *)articleSource;

@end

NS_ASSUME_NONNULL_END
