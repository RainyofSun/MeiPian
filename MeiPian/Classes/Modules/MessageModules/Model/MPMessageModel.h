//
//  MPMessageModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPMessageTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMessageModel : MPBaseModel

/** head_group_list */
@property (nonatomic,strong) NSArray <MPMessageTypeModel *>*head_group_list;
/** content_group_list */
@property (nonatomic,strong) NSArray *content_group_list;
/** first_seq_id */
@property (nonatomic,strong) NSNumber *first_seq_id;
/** has_message */
@property (nonatomic,strong) NSNumber *has_message;
/** circle_mgt */
@property (nonatomic,strong) NSNumber *circle_mgt;
/** contacts_stat */
@property (nonatomic,strong) NSDictionary *contacts_stat;

@end

NS_ASSUME_NONNULL_END
