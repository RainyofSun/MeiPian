//
//  MPCircleRecommandViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPCircleRecommandViewModel : MPBaseViewModel

/// 加载推荐数据
- (void)MPCircleRecommandInfo:(ReturnValueBlock)dataBlock;

@end

NS_ASSUME_NONNULL_END
