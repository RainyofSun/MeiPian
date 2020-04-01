//
//  MPArticleAuthorModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPArticleAuthorModel : MPBaseModel

/** autherId */
@property (nonatomic,strong) NSString *autherId;
/** uri */
@property (nonatomic,strong) NSString *uri;
/** is_official */
@property (nonatomic,strong) NSNumber *is_official;
/** nickname */
@property (nonatomic,strong) NSString *nickname;
/** head_img */
@property (nonatomic,strong) NSString *head_img;
/** bedge_img */
@property (nonatomic,strong) NSString *bedge_img;
/** label_img */
@property (nonatomic,strong) NSString *label_img;
/** tag_img */
@property (nonatomic,strong) NSString *tag_img;

@end

NS_ASSUME_NONNULL_END
