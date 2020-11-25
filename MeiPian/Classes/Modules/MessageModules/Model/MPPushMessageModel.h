//
//  MPPushMessageModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPPushMessageModel : MPMessageTypeModel

/** time */
@property (nonatomic,strong) NSString *time;
/** info */
@property (nonatomic,strong) NSString *info;

@end

NS_ASSUME_NONNULL_END
