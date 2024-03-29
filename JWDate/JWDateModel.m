//
//  JWDateModel.m
//  JWDate
//
//  Created by 丽泽 on 2019/6/13.
//  Copyright © 2019年 lize. All rights reserved.
//

#import "JWDateModel.h"

struct doubi {
    NSString *doubName;
    NSString *doubAge;
};
/**
 * test
 
 */

@implementation JWDateModel

//2019-8-8
/**
 * 字符串格式，转时间  时间差
 */
// 获取当前月的总天数
+ (NSInteger)totalDaysInMonthFromStr:(NSString *)dateStr
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; // 默认时间 GMT +8
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:dateStr];
    return [self totalDaysInMonthFromDate:date];
}

+ (NSInteger)totalDaysInMonthFromDate:(NSDate *)date
{
    NSRange dayRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return dayRange.length;
}

// 获得第一天的日期
+ (NSInteger)weekDayMonthOfFirstDayFromStr:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *newDate = [formatter dateFromString:dateStr];
    
    // test
    NSDate *firstDate = nil;
    double interval = 0;

    BOOL OK = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    if (!OK) {
        return 0;
    }
    return [self weekDayMonthOfFirstDayFromDate:firstDate];
}

+ (NSInteger)weekDayMonthOfFirstDayFromDate:(NSDate *)date
{
    // 1 sun  2 Mon 3 Tues
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSInteger firstDayOfMonthInt = [calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    NSInteger firstDayOfMonthInt = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    return firstDayOfMonthInt - 1;
}

- (NSInteger)month:(NSInteger)month year:(NSInteger)year {
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        case 2:// 需要判断是否是闰年
        {
            if (year % 4 == 0 && year % 100 != 0) { // 普通年份，非100整数倍
                return 29;
            }
            if (year % 400 == 0) { // 世纪年份
                return 29;
            }
            return 28;
        }
        default:
            return 30;
            break;
    }
}


@end
