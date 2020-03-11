//
//  NSObject+Time.m
//  MeiPian
//
//  Created by 刘冉 on 2019/9/4.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import "NSObject+Time.h"
#include <sys/sysctl.h>

@implementation NSObject (Time)

- (long long)getNowTimestamp{
    long long timestamp = [[NSDate date] timeIntervalSince1970] * 1000;
    return timestamp;
}

- (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}

- (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    return confromTimespStr;
}

- (NSString *)currentTimeStr {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormat stringFromDate:[NSDate date]];
    return  currentDateStr;
}

- (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

- (int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay format:(NSString *)format {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *dateA = [dateFormat dateFromString:oneDay];
    NSDate *dateB = [dateFormat dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
}


//系统当前运行了多长时间
- (NSTimeInterval)uptimeSinceLastBoot {
  //获取当前设备时间时间戳 受用户修改时间影响
  struct timeval now;
  struct timezone tz;
  gettimeofday(&now, &tz);
//    NSLog(@"gettimeofday: %ld", now.tv_sec);

  //获取系统上次重启的时间戳 受用户修改时间影响
  struct timeval boottime;
  int mib[2] = {CTL_KERN, KERN_BOOTTIME};
  size_t size = sizeof(boottime);

  double uptime = -1;

  if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0) {
      //因为两个参数都会受用户修改时间的影响，因此它们想减的值是不变的
      uptime = now.tv_sec - boottime.tv_sec;
      uptime += (double)(now.tv_usec - boottime.tv_usec) / 1000000.0;
  }
  return uptime;
}

// 时间戳转换小时、分、秒 xx:xx:xx
- (NSString *)getHour:(NSInteger)totalTime{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",totalTime/3600];
    return str_hour;
}

- (NSString *)getMinute:(NSInteger)totalTime {
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(totalTime%3600)/60];
    return str_minute;
}

- (NSString *)getSecond:(NSInteger)totalTime {
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",totalTime%60];
    return str_second;
}

@end
