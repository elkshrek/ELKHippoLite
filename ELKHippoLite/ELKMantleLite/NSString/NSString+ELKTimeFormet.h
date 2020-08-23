//
//  NSString+ELKTimeFormet.h
//  ELKParallel
//
//  Created by wing on 2019/12/30.
//  Copyright © 2019 wing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 时间格式枚举
typedef NS_OPTIONS(NSUInteger, ELKDateFormatStyle) {
    /// yyyy-MM-dd HH:mm
    ELKDateFmtNormal1       = 1,
    /// yyyy-MM-dd HH:mm:ss
    ELKDateFmtExplicit1     = 2,
    
    /// yyyy年MM月dd日 HH:mm
    ELKDateFmtNormal2       = 3,
    /// yyyy年MM月dd日 HH:mm:ss
    ELKDateFmtExplicit2     = 4,
    
    /// yyyy-M-d
    ELKDateFmtNormal3       = 5,
    /// yyyy-MM-dd
    ELKDateFmtExplicit3     = 6,
    
    /// yyyy年M月d日
    ELKDateFmtNormal4       = 7,
    /// yyyy年MM月dd日
    ELKDateFmtExplicit4     = 8,
    
};


@interface NSString (ELKTimeFormet)


/// 时间戳=>时间：时间格式字符串+时间戳->格式化时间
/// @param format    时间格式
/// @param timestamp 毫秒级时间戳字符串
+ (NSString *)elk_timeWithFormat:(NSString *)format timestamp:(nonnull NSString *)timestamp;


/// 时间转换，根据传入的时间格式转换时间戳
/// @param dateStyle ELKDateFormatStyle
/// @param timestamp 毫秒级时间戳字符串
+ (NSString *)elk_timeWithDateStyle:(ELKDateFormatStyle)dateStyle timestamp:(NSString *)timestamp;


/// 时间戳=>yyyy-MM-dd HH:mm格式时间
/// @param timestamp 时间戳字符串
+ (NSString *)elk_timeForNormal:(NSString *)timestamp;


/// 获取当前时间戳(毫秒级时间戳)
+ (NSString*)elk_getNowTimestamp;


/// 格式化时间=>时间戳(毫秒级)：时间格式字符串+格式化时间->时间戳
/// @param format 时间格式
/// @param time   符合上面格式的时间字符串
+ (NSString *)elk_timestampWithFormat:(NSString *)format time:(NSString *)time;


/// NSDate=>时间戳（毫秒级时间戳长13位）
/// @param date 日期
+ (NSString *)elk_timestampOfDate:(NSDate *)date;


/// 日期时间戳=>计算生日
/// @param birthStamp 生日时间戳
+ (NSString *)elk_ageOfBirthStamp:(NSString *)birthStamp;





@end

NS_ASSUME_NONNULL_END
