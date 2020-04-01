//
//  MPJXTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPJingXuanConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPJXTableViewCell : UITableViewCell

- (void)loadJingXuanCellSource:(MPJingXuanConfigModel *)modelSource;

@end

NS_ASSUME_NONNULL_END
