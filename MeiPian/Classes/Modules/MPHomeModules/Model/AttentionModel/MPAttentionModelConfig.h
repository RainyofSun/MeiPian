//
//  MPAttentionModelConfig.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPFindMoreModel.h"
#import "MPInterestUsersModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MPAttentionCellStyle_MorePeople,
    MPAttentionCellStyle_TopTip,
    MPAttentionCellStyle_People,
} MPAttentionCellStyle;

@interface MPAttentionModelConfig : MPBaseModel

/** find_more */
@property (nonatomic,strong) MPFindMoreModel *findMore;
/** interest_users */
@property (nonatomic,strong) MPInterestUsersModel *interestUsers;

/// 自定义字段
/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;
/** cellType */
@property (nonatomic,assign) MPAttentionCellStyle cellType;

@end

NS_ASSUME_NONNULL_END
