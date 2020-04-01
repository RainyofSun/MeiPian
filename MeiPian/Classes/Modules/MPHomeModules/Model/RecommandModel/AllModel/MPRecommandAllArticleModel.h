//
//  MPRecommandAllArticleModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPFeedTagInfoModel : MPBaseModel

/** tag_name */
@property (nonatomic,strong) NSString *tag_name;
/** uri */
@property (nonatomic,strong) NSString *uri;

@end

@interface MPRecommandAllArticleModel : MPBaseModel

/** articleId */
@property (nonatomic,strong) NSNumber *articleId;
/** addition_user_id */
@property (nonatomic,strong) NSNumber *addition_user_id;
/** visit_count */
@property (nonatomic,strong) NSNumber *visit_count;
/** praise_count */
@property (nonatomic,strong) NSNumber *praise_count;
/** image_count */
@property (nonatomic,strong) NSString *image_count;
/** comment_count */
@property (nonatomic,strong) NSString *comment_count;
/** mask_id */
@property (nonatomic,strong) NSString *mask_id;
/** uri */
@property (nonatomic,strong) NSString *uri;
/** abstract */
@property (nonatomic,strong) NSString *abstract;
/** title */
@property (nonatomic,strong) NSString *title;
/** addition */
@property (nonatomic,strong) NSString *addition;
/** addition_uri */
@property (nonatomic,strong) NSString *addition_uri;
/** cover_imgs */
@property (nonatomic,strong) NSArray <NSString *>*cover_imgs;
/** feed_tag_info */
@property (nonatomic,strong) MPFeedTagInfoModel *feed_tag_info;

@end

NS_ASSUME_NONNULL_END
