//
//  MPJingXuanArticleModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPJingXuanArticleModel : MPBaseModel

/** uri */
@property (nonatomic,strong) NSString *uri;
/** mask_id */
@property (nonatomic,strong) NSString *mask_id;
/** title */
@property (nonatomic,strong) NSString *title;
/** comment_count */
@property (nonatomic,strong) NSNumber *comment_count;
/** visit_count */
@property (nonatomic,strong) NSNumber *visit_count;
/** cover_imgs */
@property (nonatomic,strong) NSArray <NSString *>*cover_imgs;

@end

NS_ASSUME_NONNULL_END
