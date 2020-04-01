//
//  MPRecommadAllConfigModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"
#import "MPRecommandAllModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    RecommandAllArticleCellStyle_OnePic,
    RecommandAllArticleCellStyle_ThreePic,
    RecommandAllArticleCellStyle_AdVideo,
    RecommandAllArticleCellStyle_AdApp,
} RecommandAllArticleCellStyle;

@interface MPRecommadAllConfigModel : MPBaseModel

/** recommandAllModel */
@property (nonatomic,strong) MPRecommandAllModel *recommandAllModel;
/** cellType */
@property (nonatomic,assign) RecommandAllArticleCellStyle cellType;
/** cellHeight */
@property (nonatomic,assign) CGFloat cellHeight;
/** imgCountW */
@property (nonatomic,assign) CGFloat imgCountW;
/** articleTypeBtnW */
@property (nonatomic,assign) CGFloat articleTypeBtnW;
/** imgCountAttributeStr */
@property (nonatomic,strong) NSAttributedString *imgCountAttributeStr;
/** articleTypeAttributeStr */
@property (nonatomic,strong) NSAttributedString *articleTypeAttributeStr;

@end

NS_ASSUME_NONNULL_END
