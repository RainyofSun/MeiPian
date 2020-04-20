//
//  MPMineArticleCellTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPMineWorksModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMineArticleCellTableViewCell : UITableViewCell

- (void)loadMineWorkModel:(MPMineWorksModel *)worksModel;

@end

NS_ASSUME_NONNULL_END
