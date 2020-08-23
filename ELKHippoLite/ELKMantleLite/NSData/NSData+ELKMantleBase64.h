//
//  NSData+ELKMantleBase64.h
//  ELKCommonDemo
//
//  Created by wing on 2020/5/8.
//  Copyright © 2020 wing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ELKMantleBase64)

/**
 *  @brief  字符串base64后转data
 *  @param string 传入字符串
 *  @return 传入字符串 base64后的data
 */
+ (NSData *)elk_dataWithBase64EncodedString:(NSString *)string;


/**
 *  @brief  NSData转string
 *  @param wrapWidth 换行长度  76  64
 *  @return base64后的字符串
 */
- (NSString *)elk_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;


/**
 *  @brief  NSData转string 换行长度默认64
 *  @return base64后的字符串
 */
- (NSString *)elk_base64EncodedString;



@end

NS_ASSUME_NONNULL_END
