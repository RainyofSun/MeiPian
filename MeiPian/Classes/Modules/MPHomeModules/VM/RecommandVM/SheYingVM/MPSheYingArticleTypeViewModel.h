//
//  MPSheYingArticleTypeViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"
#import "MPSheYingArticleTypeConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPSheYingArticleTypeViewModel : MPBaseViewModel

/// 获取文章类型数据
- (void)MPSheYingArticleTypeInfo:(ReturnValueBlock)dataBlock;

@end

NS_ASSUME_NONNULL_END
