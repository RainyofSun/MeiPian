//
//  MPAttentionModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPFindMoreModel.h"
#import "MPInterestUsersModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPAttentionModel : MPBaseModel

/** find_more */
@property (nonatomic,strong) MPFindMoreModel *find_more;
/** interest_users */
@property (nonatomic,strong) NSArray <MPInterestUsersModel *>*interest_users;
/** has_follow */
@property (nonatomic,strong) NSNumber *has_follow;
/** interest_user_index */
@property (nonatomic,strong) NSNumber *interest_user_index;

@end

NS_ASSUME_NONNULL_END
