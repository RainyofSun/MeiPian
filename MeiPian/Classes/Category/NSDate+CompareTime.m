//
//  NSDate+CompareTime.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "NSDate+CompareTime.h"

@implementation NSDate (CompareTime)

- (NSInteger)getDaysTo:(NSDate *)endDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];
   //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:self];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return dayComponents.day;
}

@end
