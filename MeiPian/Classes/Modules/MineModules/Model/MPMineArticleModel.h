//
//  MPMineArticleModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineInfoModel.h"
#import "MPMineWorksModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMineArticleModel : MPMineInfoModel

/** share_count */
@property (nonatomic,strong) NSNumber *share_count;
/** articles */
@property (nonatomic,strong) NSArray <MPMineWorksModel *>*articles;
/** videos */
@property (nonatomic,strong) NSArray *videos;
/** albums */
@property (nonatomic,strong) NSArray *albums;

@end

NS_ASSUME_NONNULL_END
