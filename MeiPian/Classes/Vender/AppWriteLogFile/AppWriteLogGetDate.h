//
//  AppWriteLogGetDate.h
//  LibTools
//
//  Created by 刘冉 on 2018/11/30.
//  Copyright © 2018 LRCY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppWriteLogGetDate : NSObject

- (NSString *)getFileName;
/// date转字符串
- (NSString *)getTimeStr:(NSDate *)date;
/// 字符串转date
- (NSDate *)getTimeDate:(NSString *)timeStr;
/// 判断间隔时间(day)
- (NSInteger)getDifferenceByDate:(NSDate *)oldDate;
/// 获取当前时间
- (NSString *)getTimeNow;
/// 时间排序
- (NSArray *)sortTime:(NSMutableArray *)dateArray isAscending:(BOOL)ascending;

@end

NS_ASSUME_NONNULL_END
