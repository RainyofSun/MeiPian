//
//  MPCircleInterestArticleAuthorModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCircleInterestArticleAuthorModel : MPBaseModel

/** authorID */
@property (nonatomic,strong) NSNumber *authorID;
/** uri */
@property (nonatomic,strong) NSString *uri;
/** nickname */
@property (nonatomic,strong) NSString *nickname;
/** head_img */
@property (nonatomic,strong) NSString *head_img;

@end

NS_ASSUME_NONNULL_END
