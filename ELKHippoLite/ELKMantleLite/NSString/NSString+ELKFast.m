//
//  NSString+ELKFast.m
//  ELKParallel
//
//  Created by wing on 2019/12/30.
//  Copyright © 2019 wing. All rights reserved.
//

#import "NSString+ELKFast.h"

@implementation NSString (ELKFast)



/// 计算字符串的size，根据给定的限制大小和字体
/// @param limitSize 限制大小
/// @param font      给定字体
- (CGSize)elk_sizeWithLimit:(CGSize)limitSize font:(UIFont *)font
{
    CGSize strSize = [self boundingRectWithSize:limitSize options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:@{NSFontAttributeName:font} context:nil].size;
    return strSize;
}
/// 计算字符串的size，根据给定的限制大小和系统字体大小值
/// @param limitSize 限制大小
/// @param fontSize  系统字体大小数值
- (CGSize)elk_sizeWithLimit:(CGSize)limitSize fontSize:(CGFloat)fontSize
{
    CGSize strSize = [self elk_sizeWithLimit:limitSize font:[UIFont systemFontOfSize:fontSize]];
    return strSize;
}



/// 计算字符串高度，根据给定限制宽度和字体
/// @param limitWidth 字体限制宽度
/// @param font       给定字体
- (CGFloat)elk_heightWithLimit:(CGFloat)limitWidth font:(UIFont *)font
{
    CGSize strSize = [self elk_sizeWithLimit:CGSizeMake(limitWidth, CGFLOAT_MAX) font:font];
    return strSize.height;
}
/// 计算字符串高度，根据给定限制宽度和系统字体大小值
/// @param limitWidth 字体限制宽度
/// @param fontSize   给定系统字体大小值
- (CGFloat)elk_heightWithLimit:(CGFloat)limitWidth fontSize:(CGFloat)fontSize
{
    CGSize strSize = [self elk_sizeWithLimit:CGSizeMake(limitWidth, CGFLOAT_MAX) fontSize:fontSize];
    return strSize.height;
}



/// 计算字符串宽度，根据给定限制高度和字体
/// @param limitHeight 字体限制高度
/// @param font        给定字体
- (CGFloat)elk_widthWithLimit:(CGFloat)limitHeight font:(UIFont *)font
{
    CGSize strSize = [self elk_sizeWithLimit:CGSizeMake(CGFLOAT_MAX, limitHeight) font:font];
    return strSize.width;
}
/// 计算字符串宽度，根据给定限制宽度和系统字体大小值
/// @param limitHeight 字体限制高度
/// @param fontSize    给定系统字体大小值
- (CGFloat)elk_widthWithLimit:(CGFloat)limitHeight fontSize:(CGFloat)fontSize
{
    CGSize strSize = [self elk_sizeWithLimit:CGSizeMake(CGFLOAT_MAX, limitHeight) fontSize:fontSize];
    return strSize.width;
}



/// 反转字符串
- (NSString *)elk_reverseString
{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSInteger charIndex = [self length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subRange = NSMakeRange(charIndex, 1);
        [resultString appendString:[self substringWithRange:subRange]];
    }
    return resultString;
}



/// 去除字符串首尾空格
- (NSString *)elk_trimWhiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
/// 去除字符串首尾空格与空行
- (NSString *)elk_trimWhiteSpaceAndNewlines
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



@end
