//
//  MPCircleRecommandConfigModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCircleRecommandModel : MPBaseModel

/** name */
@property (nonatomic,strong) NSString *name;
/** thumb_image */
@property (nonatomic,strong) NSString *thumb_image;
/** bedge_image_url */
@property (nonatomic,strong) NSString *bedge_image_url;
/** recommandID */
@property (nonatomic,strong) NSNumber *recommandID;
/** category_id */
@property (nonatomic,strong) NSNumber *category_id;
/** host_user_id */
@property (nonatomic,strong) NSNumber *host_user_id;
/** circle_forbidden */
@property (nonatomic,strong) NSNumber *circle_forbidden;
/** is_joined */
@property (nonatomic,strong) NSNumber *is_joined;
/** notice */
@property (nonatomic,strong) NSNumber *notice;

@end

@interface MPCircleRecommandConfigModel : MPBaseModel

/** circles */
@property (nonatomic,strong) NSArray <MPCircleRecommandModel *>*circles;

@end

NS_ASSUME_NONNULL_END
