//
//  MPMessageTypeTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPMessageTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMessageTypeTableViewCell : UITableViewCell

- (void)loadMessageTypeCellSource:(NSArray <MPMessageTypeModel *>*)typeModelSource;
- (void)cellAlphaAnimation;

@end

NS_ASSUME_NONNULL_END
