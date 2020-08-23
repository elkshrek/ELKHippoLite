//
//  NSDate+ELKMantleFormat.m
//  ELKHippoLite
//
//  Created by wing on 2020/4/20.
//  Copyright © 2020 wing. All rights reserved.
//

#import "NSDate+ELKMantleFormat.h"

@implementation NSDate (ELKMantleFormat)


/// 时间戳=》日期：时间戳字符串=>NSDate
/// @param timestamp 时间戳字符串
+ (NSDate *)elk_dateFromTimestamp:(NSString *)timestamp
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
