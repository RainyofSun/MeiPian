//
//  MPCircleInterestArticleTalkModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCircleInterestArticleTalkModel : MPBaseModel

/** talkID */
@property (nonatomic,strong) NSNumber *talkID;
/** text */
@property (nonatomic,strong) NSString *text;
/** visit_count */
@property (nonatomic,strong) NSNumber *visit_count;
/** comment_count */
@property (nonatomic,strong) NSNumber *comment_count;
/** praise_count */
@property (nonatomic,strong) NSNumber *praise_count;
/** summary */
@property (nonatomic,strong) NSString *summary;
/** img */
@property (nonatomic,strong) NSString *img;
/** create_time */
@property (nonatomic,strong) NSNumber *create_time;
/** display_time */
@property (nonatomic,strong) NSNumber *display_time;

@end

NS_ASSUME_NONNULL_END
