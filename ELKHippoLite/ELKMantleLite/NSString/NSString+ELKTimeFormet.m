//
//  NSString+ELKTimeFormet.m
//  ELKParallel
//
//  Created by wing on 2019/12/30.
//  Copyright © 2019 wing. All rights reserved.
//

#import "NSString+ELKTimeFormet.h"

@implementation NSString (ELKTimeFormet)


/// 时间戳=>时间：时间格式字符串+时间戳->格式化时间
/// @param format    时间格式
/// @param timestamp 毫秒级时间戳字符串
+ (NSString *)elk_timeWithFormat:(NSString *)format timestamp:(nonnull NSString *)timestamp
{
    NSDate *date = [NSString elk_dateWithTimestamp:timestamp];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}


/// 时间戳=>yyyy-MM-dd HH:mm格式时间
/// @param timestamp 时间戳字符串
+ (NSString *)elk_timeForNormal:(NSString *)timestamp
{
    NSString *dFormat = @"yyyy-MM-dd HH:mm";
    NSString *timeString = [self elk_timeWithFormat:dFormat timestamp:timestamp];
    return timeString;
}


/// 时间转换，根据传入的时间格式转换时间戳
/// @param dateStyle ELKDateFormatStyle
/// @param timestamp 毫秒级时间戳字符串
+ (NSString *)elk_timeWithDateStyle:(ELKDateFormatStyle)dateStyle timestamp:(NSString *)timestamp
{
    NSString *dFormat = @"yyyy-MM-dd HH:mm";
    switch (dateStyle) {
        case ELKDateFmtNormal1:
            dFormat = @"yyyy-MM-dd HH:mm";
            break;
        case ELKDateFmtExplicit1:
            dFormat = @"yyyy-MM-dd HH:mm:ss";
            break;
        case ELKDateFmtNormal2:
            dFormat = @"yyyy年MM月dd日 HH:mm";
            break;
        case ELKDateFmtExplicit2:
            dFormat = @"yyyy年MM月dd日 HH:mm:ss";
            break;
        case ELKDateFmtNormal3:
            dFormat = @"yyyy-M-d";
            break;
        case ELKDateFmtExplicit3:
            dFormat = @"yyyy-MM-dd";
            break;
        case ELKDateFmtNormal4:
            dFormat = @"yyyy年M月d日";
            break;
        case ELKDateFmtExplicit4:
            dFormat = @"yyyy年MM月dd日";
            break;
            
        default:
            dFormat = @"yyyy-MM-dd HH:mm";
            break;
    }
    NSString *timeString = [self elk_timeWithFormat:dFormat timestamp:timestamp];
    return timeString;
}


/// 获取当前时间戳(毫秒级时间戳)
+ (NSString*)elk_getNowTimestamp
{
    NSDate *date = [NSDate date];
    return [self elk_timestampOfDate:date];
}


/// 格式化时间=>时间戳(毫秒级)：时间格式字符串+格式化时间->时间戳
/// @param format 时间格式
/// @param time   符合上面格式的时间字符串
+ (NSString *)elk_timestampWithFormat:(NSString *)format time:(NSString *)time
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *date = [dateFormat dateFromString:time];
    return [self elk_timestampOfDate:date];
}


/// NSDate=>时间戳（毫秒级时间戳长13位）
/// @param date 日期
+ (NSString *)elk_timestampOfDate:(NSDate *)date
{
    NSTimeInterval timeInter = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.f", timeInter * 1000];
    return timeString;
}


/// 日期时间戳=>计算生日
/// @param birthStamp 生日时间戳
+ (NSString *)elk_ageOfBirthStamp:(NSString *)birthStamp
{
    NSDate *birthDate = [NSString elk_dateWithTimestamp:birthStamp];
    NSDate *curDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComp = [calendar components:NSCalendarUnitYear fromDate:birthDate toDate:curDate options:0];
    
    return [NSString stringWithFormat:@"%ld", (long)dateComp.year];
}


/// 时间戳=>日期，返回NSDate对象
/// @param timestamp 时间戳字符串
+ (NSDate *)elk_dateWithTimestamp:(NSString *)timestamp
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    if (timestamp) {
        if (timestamp.length == 13) {
            interval = ceill([timestamp doubleValue] / 1000);
        } else if (timestamp.length == 10) {
            interval = ceill([timestamp doubleValue]);
        }
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return date;
}



@end
