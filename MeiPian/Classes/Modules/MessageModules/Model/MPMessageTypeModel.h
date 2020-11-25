//
//  MPMessageTypeModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMessageTypeModel : MPBaseModel

/** unread_count */
@property (nonatomic,strong) NSNumber *unread_count;
/** gift_msg_unread_count */
@property (nonatomic,strong) NSNumber *gift_msg_unread_count;
/** type */
@property (nonatomic,strong) NSNumber *type;
/** uri */
@property (nonatomic,strong) NSString *uri;
/** title */
@property (nonatomic,strong) NSString *title;
/** icon */
@property (nonatomic,strong) NSString *icon;
/** bedge_icon */
@property (nonatomic,strong) NSString *bedge_icon;
/** gift_icon */
@property (nonatomic,strong) NSString *gift_icon;

/// 自定义字段
/** unreadNumW */
@property (nonatomic,assign) CGFloat unreadNumW;

@end

NS_ASSUME_NONNULL_END
