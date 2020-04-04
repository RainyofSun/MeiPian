//
//  MPRecommandViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MPRecommandArticleType_All,
    MPRecommandArticleType_JingXuan,
    MPRecommandArticleType_SheYing,
    MPRecommandArticleType_QingGan,
    MPRecommandArticleType_WenXue,
    MPRecommandArticleType_LvXing
} MPRecommandArticleType;

@interface MPRecommandViewModel : MPBaseViewModel

/// 获取数据头
- (NSString *)requestHeader:(NSInteger)page articleType:(MPRecommandArticleType)type;
/// 获取推荐的文章信息
- (void)MPRecommandArticleInfo:(ReturnValueBlock)dataBlock requestType:(MPLoadingType)loadType articleType:(MPRecommandArticleType)type;
/// 获取导航栏数据
- (NSArray <NSString *>*)subNavSource;

@end

NS_ASSUME_NONNULL_END
