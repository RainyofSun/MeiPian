//
//  MPHomePageConfigModel.h
//  MeiPian
//
//  Created by 刘冉 on 2020/4/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPHomePageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPHomePageConfigModel : MPBaseModel

/** main_channel */
@property (nonatomic,strong) NSArray <MPHomePageModel *>*main_channel;
/** sub_channel */
@property (nonatomic,strong) NSArray <MPHomePageModel *>*sub_channel;

@end

NS_ASSUME_NONNULL_END
