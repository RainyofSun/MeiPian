//
//  MPMessageViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"
#import "MPMessageConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMessageViewModel : MPBaseViewModel

/** bedgeNum */
@property (nonatomic,readonly) NSInteger bedgeNum;

/// 获取数据
- (void)MPMessageRequestInfo:(ReturnValueBlock)dataBlock loadType:(MPLoadingType)loadType;

@end

NS_ASSUME_NONNULL_END
