//
//  MPJingXuanAuthorModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPJingXuanAuthorModel : MPBaseModel

/** uri */
@property (nonatomic,strong) NSString *uri;
/** authorID */
@property (nonatomic,strong) NSString *authorID;
/** head_img */
@property (nonatomic,strong) NSString *head_img;
/** nickname */
@property (nonatomic,strong) NSString *nickname;

@end

NS_ASSUME_NONNULL_END
