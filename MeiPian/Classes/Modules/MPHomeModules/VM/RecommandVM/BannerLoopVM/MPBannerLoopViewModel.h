//
//  MPBannerLoopViewModel.h
//  MeiPian
//
//  Created by 刘冉 on 2020/4/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"
#import "MPBannerLoopModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPBannerLoopViewModel : MPBaseViewModel

/// 轮播图数据
- (NSDictionary *)bannerLoopSource;
/// 点击轮播图事件处理
- (NSString *)touchBannerLoopLink:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
