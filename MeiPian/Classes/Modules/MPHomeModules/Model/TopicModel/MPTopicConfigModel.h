//
//  MPTopicConfigModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPTopicConfigModel : MPBaseModel

/** topicID */
@property (nonatomic,strong) NSNumber *topicID;
/** praise_count */
@property (nonatomic,strong) NSNumber *praise_count;
/** sort */
@property (nonatomic,strong) NSNumber *sort;
/** enable_display */
@property (nonatomic,strong) NSNumber *enable_display;
/** enable_contribute */
@property (nonatomic,strong) NSNumber *enable_contribute;
/** follow_count */
@property (nonatomic,strong) NSNumber *follow_count;
/** class_id */
@property (nonatomic,strong) NSNumber *class_id;
/** rcmded */
@property (nonatomic,strong) NSNumber *rcmded;
/** rcmded_at */
@property (nonatomic,strong) NSNumber *rcmded_at;
/** rcmded_sort */
@property (nonatomic,strong) NSNumber *rcmded_sort;
/** contribute_end_time */
@property (nonatomic,strong) NSNumber *contribute_end_time;
/** review_end_time */
@property (nonatomic,strong) NSNumber *review_end_time;
/** article_count */
@property (nonatomic,strong) NSString *article_count;
/** name */
@property (nonatomic,strong) NSString *name;
/** img_url */
@property (nonatomic,strong) NSString *img_url;
/** cover_img */
@property (nonatomic,strong) NSString *cover_img;
/** descriptionStr */
@property (nonatomic,strong) NSString *descriptionStr;
/** profile */
@property (nonatomic,strong) NSString *profile;
/** profile_img */
@property (nonatomic,strong) NSString *profile_img;
/** links */
@property (nonatomic,strong) NSString *links;
/** notice_link */
@property (nonatomic,strong) NSString *notice_link;
/** created_at */
@property (nonatomic,strong) NSString *created_at;
/** uri */
@property (nonatomic,strong) NSString *uri;

@end

NS_ASSUME_NONNULL_END
