//
//  MPMineInfoModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPGiftsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMineInfoModel : MPBaseModel

/** cover_img_url */
@property (nonatomic,strong) NSString *cover_img_url;
/** head_img_url */
@property (nonatomic,strong) NSString *head_img_url;
/** nickname */
@property (nonatomic,strong) NSString *nickname;
/** gender */
@property (nonatomic,strong) NSNumber *gender;
/** favorite_count */
@property (nonatomic,strong) NSNumber *favorite_count;
/** follow_count */
@property (nonatomic,strong) NSNumber *follow_count;
/** follower_count */
@property (nonatomic,strong) NSNumber *follower_count;
/** visit_count */
@property (nonatomic,strong) NSNumber *visit_count;
/** gifts */
@property (nonatomic,strong) MPGiftsModel *gifts;
/** member_type */
@property (nonatomic,strong) NSNumber *member_type;
/** member_status */
@property (nonatomic,strong) NSNumber *member_status;
/** member_dynamic_img */
@property (nonatomic,strong) NSString *member_dynamic_img;
/** famous_type */
@property (nonatomic,strong) NSNumber *famous_type;
/** bedge_img_url */
@property (nonatomic,strong) NSString *bedge_img_url;
/** label_img_url */
@property (nonatomic,strong) NSString *label_img_url;
/** author_label_icon */
@property (nonatomic,strong) NSString *author_label_icon;
/** author_label_title */
@property (nonatomic,strong) NSString *author_label_title;
/** phone_num */
@property (nonatomic,strong) NSString *phone_num;
/** works_count */
@property (nonatomic,strong) NSString *works_count;
/** container_count */
@property (nonatomic,strong) NSString *container_count;
/** praised_works_count */
@property (nonatomic,strong) NSString *praised_works_count;
/** column_visited_history_uri */
@property (nonatomic,strong) NSString *column_visited_history_uri;
/** province */
@property (nonatomic,strong) NSString *province;
/** city */
@property (nonatomic,strong) NSString *city;
/** balance */
@property (nonatomic,strong) NSString *balance;
/** nickname_remaining_update_count */
@property (nonatomic,strong) NSString *nickname_remaining_update_count;
/** nickname_next_modify_timestamp */
@property (nonatomic,strong) NSNumber *nickname_next_modify_timestamp;
/** joined_circle_count */
@property (nonatomic,strong) NSNumber *joined_circle_count;
/** follow_feed_unread */
@property (nonatomic,strong) NSNumber *follow_feed_unread;

// 自定义字段
/** attentionStr */
@property (nonatomic,strong) NSAttributedString *attentionStr;
/** fansStr */
@property (nonatomic,strong) NSAttributedString *fansStr;
/** visitStr */
@property (nonatomic,strong) NSAttributedString *visitStr;

@end

NS_ASSUME_NONNULL_END
