//
//  MPCircleInterestViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCircleInterestViewModel : MPBaseViewModel

/// 获取感兴趣文章数据
- (void)MPInterestArticleInfo:(ReturnValueBlock)dataBlock loadType:(MPLoadingType)loadType;

@end

NS_ASSUME_NONNULL_END
