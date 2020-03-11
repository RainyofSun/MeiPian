//
//  NSObject+Time.h
//  MeiPian
//
//  Created by 刘冉 on 2019/9/4.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Time)

/// 获取当前系统时间的时间戳
- (long long)getNowTimestamp;
/// 将某个时间转化成时间戳
- (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
/// 将某个时间戳转化成 时间
- (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
/// 获取当前时间字符串
- (NSString *)currentTimeStr;
/// 简单将时间字符串转换为NSDate
- (NSDate *)dateFromString:(NSString *)dateString;
/// 对比两个时间的先后关系
- (int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay format:(NSString *)format;
/// 系统当前运行的时间
- (NSTimeInterval)uptimeSinceLastBoot;
/// 时间戳转换小时、分、秒 xx:xx:xx
- (NSString *)getHour:(NSInteger)totalTime;
- (NSString *)getMinute:(NSInteger)totalTime;
- (NSString *)getSecond:(NSInteger)totalTime;

@end

NS_ASSUME_NONNULL_END
