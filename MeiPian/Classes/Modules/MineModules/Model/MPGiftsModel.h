//
//  MPGiftsModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPGiftsModel : MPBaseModel

/** flower_icon */
@property (nonatomic,strong) NSString *flower_icon;
/** flower_list_uri */
@property (nonatomic,strong) NSString *flower_list_uri;
/** flower_count */
@property (nonatomic,strong) NSNumber *flower_count;

@end

NS_ASSUME_NONNULL_END
