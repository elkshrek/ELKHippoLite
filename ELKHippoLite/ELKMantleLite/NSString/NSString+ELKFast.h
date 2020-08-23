//
//  NSString+ELKFast.h
//  ELKParallel
//
//  Created by wing on 2019/12/30.
//  Copyright © 2019 wing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ELKFast)


/// 计算字符串的size，根据给定的限制大小和字体
/// @param limitSize 限制大小
/// @param font      给定字体
- (CGSize)elk_sizeWithLimit:(CGSize)limitSize font:(UIFont *)font;
/// 计算字符串的size，根据给定的限制大小和系统字体大小值
/// @param limitSize 限制大小
/// @param fontSize  系统字体大小数值
- (CGSize)elk_sizeWithLimit:(CGSize)limitSize fontSize:(CGFloat)fontSize;



/// 计算字符串高度，根据给定限制宽度和字体
/// @param limitWidth 字体限制宽度
/// @param font       给定字体
- (CGFloat)elk_heightWithLimit:(CGFloat)limitWidth font:(UIFont *)font;
/// 计算字符串高度，根据给定限制宽度和系统字体大小值
/// @param limitWidth 字体限制宽度
/// @param fontSize   给定系统字体大小值
- (CGFloat)elk_heightWithLimit:(CGFloat)limitWidth fontSize:(CGFloat)fontSize;



/// 计算字符串宽度，根据给定限制高度和字体
/// @param limitHeight 字体限制高度
/// @param font        给定字体
- (CGFloat)elk_widthWithLimit:(CGFloat)limitHeight font:(UIFont *)font;
/// 计算字符串宽度，根据给定限制宽度和系统字体大小值
/// @param limitHeight 字体限制高度
/// @param fontSize    给定系统字体大小值
- (CGFloat)elk_widthWithLimit:(CGFloat)limitHeight fontSize:(CGFloat)fontSize;



/// 反转字符串
- (NSString *)elk_reverseString;



/// 去除字符串首尾空格
- (NSString *)elk_trimWhiteSpace;
/// 去除字符串首尾空格与空行
- (NSString *)elk_trimWhiteSpaceAndNewlines;




@end

NS_ASSUME_NONNULL_END
