//
//  MPMessageConfigModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPPushMessageModel.h"
#import "MPMessageModel.h"

typedef enum : NSUInteger {
    MsgCellStyle_MsgTypeCell,
    MsgCellStyle_PushMsgcell,
} MsgCellStyle;

NS_ASSUME_NONNULL_BEGIN

@interface MPMessageConfigModel : MPBaseModel

/** msgModel */
@property (nonatomic,strong) MPMessageModel *msgModel;
/** pushMsg */
@property (nonatomic,strong) NSArray <MPPushMessageModel *>*pushMsg;
/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;
/** cellStyle */
@property (nonatomic,assign) MsgCellStyle cellStyle;

@end

NS_ASSUME_NONNULL_END
