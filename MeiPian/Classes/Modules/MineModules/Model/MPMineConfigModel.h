//
//  MPMineConfigModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPMineInfoModel.h"
#import "MPMineArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMineConfigModel : MPBaseModel

/** infoModel */
@property (nonatomic,strong) MPMineInfoModel *infoModel;
/** articleModel */
@property (nonatomic,strong) MPMineArticleModel *articleModel;
/** sliderTitleSource */
@property (nonatomic,strong) NSArray <NSString *>*sliderTitleSource;
/** cellHeight */
@property (nonatomic,strong) NSArray <NSNumber *>*cellHeightSource;

@end

NS_ASSUME_NONNULL_END
