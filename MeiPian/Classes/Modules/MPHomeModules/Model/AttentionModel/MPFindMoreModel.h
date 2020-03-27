//
//  MPFindMoreModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPFindMoreModel : MPBaseModel

/** images */
@property (nonatomic,strong) NSArray <NSString *>*images;
/** title */
@property (nonatomic,strong) NSString *title;

@end

NS_ASSUME_NONNULL_END
