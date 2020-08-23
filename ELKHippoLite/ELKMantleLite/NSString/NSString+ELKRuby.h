//
//  NSString+ELKRuby.h
//  ELKParallel
//
//  Created by wing on 2019/12/30.
//  Copyright © 2019 wing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ELKRuby)


/// 字符串转Json字符串
- (NSString *)elk_jsonString;
/// 数组Array转Json字符串
/// @param array 数组
+ (NSString *)elk_jsonStringFromArray:(NSArray *)array;


/// base64编码
- (NSString *)elk_base64EncodedString;
/// base64解码
- (NSString *)elk_base64DecodedString;


/// 字符串做md5转换
- (NSString *)elk_md5WithString;


/// 字符串做哈希256
- (NSString*)elk_sha256;

/// 字符串做哈希256
/// @param string 做哈希的字符串
+ (NSString*)elk_sha256:(NSString *)string;


/// 获取设备 wifi name ios11以后需要开启相应权限
+ (NSString *)elk_wifiName;
/// 获取设备 wifi mac name ios11以后需要开启相应权限
+ (NSString *)elk_wifiMac;


/// 获取网络状态
+ (NSString *)elk_getNetWorkType;




@end

NS_ASSUME_NONNULL_END
