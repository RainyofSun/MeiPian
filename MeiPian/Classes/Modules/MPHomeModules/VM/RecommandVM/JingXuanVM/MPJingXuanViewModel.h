//
//  MPJingXuanViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommandViewModel.h"
#import "MPJingXuanConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPJingXuanViewModel : MPRecommandViewModel

/// 修改model颜色数据
- (MPJingXuanConfigModel *)modifyJingXuanModelData:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
