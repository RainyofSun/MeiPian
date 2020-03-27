//
//  MPAttentionViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPAttentionViewModel : MPBaseViewModel

/// 获取关注信息
- (void)MPAttentionPeopleInfo:(ReturnValueBlock)dataBlock;

@end

NS_ASSUME_NONNULL_END
