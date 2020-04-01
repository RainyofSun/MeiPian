//
//  MPJingXuanConfigModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPJingXuanAuthorModel.h"
#import "MPJingXuanArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPJingXuanConfigModel : MPBaseModel

/** article */
@property (nonatomic,strong) MPJingXuanArticleModel *article;
/** author */
@property (nonatomic,strong) MPJingXuanAuthorModel *author;
/** commentsText */
@property (nonatomic,strong) NSString *commentsText;

@end

NS_ASSUME_NONNULL_END
