//
//  MPTopicViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"
#import "MPTopicConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPTopicViewModel : MPBaseViewModel

/// 获取话题的文章信息
- (void)MPTopicArticleInfo:(ReturnValueBlock)dataBlock requestType:(MPLoadingType)loadType;

@end

NS_ASSUME_NONNULL_END
