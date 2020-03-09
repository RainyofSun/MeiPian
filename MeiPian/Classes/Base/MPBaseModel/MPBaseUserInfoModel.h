//
//  MPBaseUserInfoModel.h
//  YiZhan
//
//  Created by YZ_BMAC on 2020/1/14.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
/**
 * 用户基础model
 */
@interface MPBaseUserInfoModel : MPBaseModel

/** userId */
@property (nonatomic,strong) NSString *userId;
/** phone */
@property (nonatomic,strong) NSString *phone;
/** userHeadImg */
@property (nonatomic,strong) UIImage *userHeadImg;
/** realName */
@property (nonatomic,strong) NSString *realName;
/** sex */
@property (nonatomic,strong) NSString *sex;
/** token */
@property (nonatomic,strong) NSString *token;
/** tokenTimesTamp */
@property (nonatomic,strong) NSString *tokenTimesTamp;
/** age */
@property (nonatomic,strong) NSNumber *age;
/** isWork */
@property (nonatomic,strong) NSNumber *isWork;

- (void)resetData;

@end

NS_ASSUME_NONNULL_END
