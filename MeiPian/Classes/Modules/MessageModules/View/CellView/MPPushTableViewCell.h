//
//  MPPushTableViewCell.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPPushMessageModel;

NS_ASSUME_NONNULL_BEGIN

@interface MPPushTableViewCell : UITableViewCell

- (void)loadPushMsgViewSource:(MPPushMessageModel *)modelSource;

@end

NS_ASSUME_NONNULL_END
