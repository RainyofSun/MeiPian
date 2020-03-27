//
//  MPInterestUsersModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPInterestUsersModel : MPBaseModel

/** bedge_img --> vip标示 */
@property (nonatomic,strong) NSString *bedge_img;
/** head_img */
@property (nonatomic,strong) NSString *head_img;
/** label_img --> 作者质量 */
@property (nonatomic,strong) NSString *label_img;
/** member_icon */
@property (nonatomic,strong) NSString *member_icon;
/** name */
@property (nonatomic,strong) NSString *name;
/** relationship */
@property (nonatomic,strong) NSString *relationship;
/** signature */
@property (nonatomic,strong) NSString *signature;
/** summary_tips */
@property (nonatomic,strong) NSString *summary_tips;
/** uri */
@property (nonatomic,strong) NSString *uri;
/** peopleID */
@property (nonatomic,strong) NSNumber *peopleID;
/** famous_type */
@property (nonatomic,strong) NSNumber *famous_type;
/** fans_count */
@property (nonatomic,strong) NSNumber *fans_count;
/** member_status */
@property (nonatomic,strong) NSNumber *member_status;
/** member_type */
@property (nonatomic,strong) NSNumber *member_type;
/** rcmd_type */
@property (nonatomic,strong) NSNumber *rcmd_type;

/** nameW */
@property (nonatomic,assign) CGFloat nameW;

@end

NS_ASSUME_NONNULL_END
