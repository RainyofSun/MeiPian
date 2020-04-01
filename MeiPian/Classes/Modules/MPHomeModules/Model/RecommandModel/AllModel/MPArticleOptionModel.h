//
//  MPArticleOptionModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPArticleOptionModel : MPBaseModel

/** type */
@property (nonatomic,strong) NSNumber *type;
/** name */
@property (nonatomic,strong) NSString *name;
/** target_id */
@property (nonatomic,strong) NSString *target_id;

@end

NS_ASSUME_NONNULL_END
