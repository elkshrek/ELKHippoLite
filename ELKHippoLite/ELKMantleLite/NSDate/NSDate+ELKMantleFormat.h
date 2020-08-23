//
//  NSDate+ELKMantleFormat.h
//  ELKHippoLite
//
//  Created by wing on 2020/4/20.
//  Copyright © 2020 wing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ELKMantleFormat)


/// 时间戳=》日期：时间戳字符串=>NSDate
/// @param timestamp 时间戳字符串
+ (NSDate *)elk_dateFromTimestamp:(NSString *)timestamp;




@end

NS_ASSUME_NONNULL_END
