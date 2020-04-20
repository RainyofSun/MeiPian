//
//  MPMineInfoTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPMineInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMineInfoTableViewCell : UITableViewCell

- (void)loadMineInfoSource:(MPMineInfoModel *)infoModel;

@end

NS_ASSUME_NONNULL_END
