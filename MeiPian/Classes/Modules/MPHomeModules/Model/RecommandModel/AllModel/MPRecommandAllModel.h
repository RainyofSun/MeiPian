//
//  MPRecommandAllModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPArticleAuthorModel.h"
#import "MPArticleOptionModel.h"
#import "MPRecommandAllArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPRecommandAllModel : MPBaseModel

/** type */
@property (nonatomic,strong) NSNumber *type;
/** stick */
@property (nonatomic,strong) NSNumber *stick;
/** stick_id */
@property (nonatomic,strong) NSNumber *stick_id;
/** stick_start_at */
@property (nonatomic,strong) NSNumber *stick_start_at;
/** stick_expire_at */
@property (nonatomic,strong) NSNumber *stick_expire_at;
/** stick_type */
@property (nonatomic,strong) NSNumber *stick_type;
/** feed_type */
@property (nonatomic,strong) NSNumber *feed_type;
/** style */
@property (nonatomic,strong) NSNumber *style;
/** item_type */
@property (nonatomic,strong) NSNumber *item_type;
/** feed_source */
@property (nonatomic,strong) NSString *feed_source;
/** list_id */
@property (nonatomic,strong) NSString *list_id;
/** article */
@property (nonatomic,strong) MPRecommandAllArticleModel *article;
/** author */
@property (nonatomic,strong) MPArticleAuthorModel *author;
/** uninterest_option */
@property (nonatomic,strong) MPArticleOptionModel *uninterest_option;

@end

NS_ASSUME_NONNULL_END
