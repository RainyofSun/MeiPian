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

typedef enum : NSUInteger {
    MineCellStyle_info,
    MineCellStyle_Article,
} MineCellStyle;

@interface MPMineConfigModel : MPBaseModel

/** infoModel */
@property (nonatomic,strong) MPMineInfoModel *infoModel;
/** articleModel */
@property (nonatomic,strong) MPMineArticleModel *articleModel;
/** sliderTitleSource */
@property (nonatomic,strong) NSArray <NSString *>*sliderTitleSource;
/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;
/** cellType */
@property (nonatomic,assign) MineCellStyle cellType;

@end

NS_ASSUME_NONNULL_END
