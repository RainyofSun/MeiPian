//
//  AppWriteLogGetDate.m
//  LibTools
//
//  Created by 刘冉 on 2018/11/30.
//  Copyright © 2018 LRCY. All rights reserved.
//

#import "AppWriteLogGetDate.h"

@implementation AppWriteLogGetDate

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (NSString *)getTimeStr:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat stringFromDate:date];
}

- (NSDate *)getTimeDate:(NSString *)timeStr {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat dateFromString:timeStr];
}

/// 判断间隔时间
- (NSInteger)getDifferenceByDate:(NSDate *)oldDate {
    //获得当前时间
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:oldDate  toDate:now  options:0];
    return [comps day];
}

- (NSString *)getTimeNow {
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString* timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    return timeNow;
}

- (NSArray *)sortTime:(NSMutableArray *)dateArray isAscending:(BOOL)ascending{
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:ascending];
    NSMutableArray *sortDescriptors = [[NSMutableArray alloc] initWithObjects:&sorter count:1];
    NSArray *sortArray = [dateArray sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"排序完成之后数组: %@",sortArray);
    return sortArray;
}

@end
