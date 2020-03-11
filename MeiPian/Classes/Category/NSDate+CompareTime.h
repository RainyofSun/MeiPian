//
//  NSDate+CompareTime.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CompareTime)

/// 计算两个Date间间隔的天数
- (NSInteger)getDaysTo:(NSDate *)endDate;

@end

NS_ASSUME_NONNULL_END
