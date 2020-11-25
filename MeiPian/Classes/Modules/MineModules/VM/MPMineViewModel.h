//
//  MPMineViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"
#import "MPMineConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMineViewModel : MPBaseViewModel

/// 请求个人数据
- (void)MPMineInfoRequest:(ReturnValueBlock)dataBlock;

@end

NS_ASSUME_NONNULL_END
