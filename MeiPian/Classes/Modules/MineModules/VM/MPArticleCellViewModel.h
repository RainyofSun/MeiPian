//
//  MPArticleCellViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"
#import "MPMineArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPArticleCellViewModel : MPBaseViewModel

/** articleModel */
@property (nonatomic,strong) MPMineArticleModel *articleModel;

@end

NS_ASSUME_NONNULL_END
