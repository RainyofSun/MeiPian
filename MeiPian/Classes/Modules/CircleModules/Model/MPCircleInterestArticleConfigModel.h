//
//  MPCircleInterestArticleConfigModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPCircleInterestArticleAuthorModel.h"
#import "MPCircleInterestArticleTalkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCircleInterestArticleConfigModel : MPBaseModel

/** list_id */
@property (nonatomic,strong) NSNumber *list_id;
/** user */
@property (nonatomic,strong) MPCircleInterestArticleAuthorModel *user;
/** talk */
@property (nonatomic,strong) MPCircleInterestArticleTalkModel *talk;
/** articleTime */
@property (nonatomic,strong) NSString *articleTime;

@end

NS_ASSUME_NONNULL_END
