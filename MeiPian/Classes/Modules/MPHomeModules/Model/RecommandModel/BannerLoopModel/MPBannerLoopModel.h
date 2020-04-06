//
//  MPBannerLoopModel.h
//  MeiPian
//
//  Created by 刘冉 on 2020/4/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPBannerLoopModel : MPBaseModel

/** bannerID */
@property (nonatomic,strong) NSNumber *bannerID;
/** title */
@property (nonatomic,strong) NSString *title;
/** uri */
@property (nonatomic,strong) NSString *uri;
/** cover_img */
@property (nonatomic,strong) NSString *cover_img;

@end

NS_ASSUME_NONNULL_END
