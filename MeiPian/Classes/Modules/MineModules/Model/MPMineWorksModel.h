//
//  MPMineWorksModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMineWorksModel : MPBaseModel

/** workID */
@property (nonatomic,strong) NSNumber *workID;
/** article_id */
@property (nonatomic,strong) NSString *article_id;
/** visit_count */
@property (nonatomic,strong) NSString *visit_count;
/** praise_count */
@property (nonatomic,strong) NSNumber *praise_count;
/** comment_count */
@property (nonatomic,strong) NSNumber *comment_count;
/** state */
@property (nonatomic,strong) NSNumber *state;
/** category_id */
@property (nonatomic,strong) NSNumber *category_id;
/** rcmd_state */
@property (nonatomic,strong) NSNumber *rcmd_state;
/** title */
@property (nonatomic,strong) NSString *title;
/** rich_text_title */
@property (nonatomic,strong) NSString *rich_text_title;
/** cover_img_url */
@property (nonatomic,strong) NSString *cover_img_url;
/** cover_crop */
@property (nonatomic,strong) NSString *cover_crop;
/** abstract */
@property (nonatomic,strong) NSString *abstract;
/** privacy */
@property (nonatomic,strong) NSNumber *privacy;
/** container_id */
@property (nonatomic,strong) NSNumber *container_id;
/** create_time */
@property (nonatomic,strong) NSNumber *create_time;
/** circle_info */
@property (nonatomic,strong) NSString *circle_info;
/** wxmp_share_path */
@property (nonatomic,strong) NSString *wxmp_share_path;
/** has_reward */
@property (nonatomic,strong) NSNumber *has_reward;
/** enable_comment */
@property (nonatomic,strong) NSNumber *enable_comment;
/** password */
@property (nonatomic,strong) NSString *password;
/** password_v2 */
@property (nonatomic,strong) NSString *password_v2;
/** gift_switch */
@property (nonatomic,strong) NSNumber *gift_switch;
/** deleted_at */
@property (nonatomic,strong) NSNumber *deleted_at;
/** recycle_expired_at */
@property (nonatomic,strong) NSNumber *recycle_expired_at;
/** share_with_nickname */
@property (nonatomic,strong) NSNumber *share_with_nickname;
/** share_count */
@property (nonatomic,strong) NSNumber *share_count;
/** has_exposure */
@property (nonatomic,strong) NSNumber *has_exposure;

// 自定义字段
/** articleTime */
@property (nonatomic,strong) NSString *articleTime;
/** comments */
@property (nonatomic,strong) NSString *comments;

@end

NS_ASSUME_NONNULL_END
