//
//  UITextField+HZAppearance.m
//  ELKHaiTouClient
//
//  Created by 黄子乐 on 2020/5/18.
//  Copyright © 2020 wing. All rights reserved.
//

#import "UITextField+HZAppearance.h"

@implementation UITextField (HZAppearance)

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor
{
    return [self hz_setTextfieldWithFont:font textColor:textColor placeholder:nil];
}

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *_Nullable)placeholder
{
    return [self hz_setTextfieldWithFont:font textColor:textColor placeholder:placeholder backgroundColor:[UIColor whiteColor]];
}

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor attributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    UITextField *textField = [self hz_setTextfieldWithFont:font textColor:textColor placeholder:nil];
    textField.attributedPlaceholder = attributedPlaceholder;
    return textField;
}

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder backgroundColor:(UIColor *)backgroundColor {
    return [self hz_setTextfieldWithFont:font textColor:textColor placeholder:placeholder backgroundColor:backgroundColor borderStyle:UITextBorderStyleNone];
}

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder backgroundColor:(nonnull UIColor *)backgroundColor borderStyle:(UITextBorderStyle)borderStyle {
    return [self hz_setTextfieldWithFont:font textColor:textColor placeholder:placeholder backgroundColor:backgroundColor  borderStyle:borderStyle textAlignment:NSTextAlignmentLeft];
}

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder backgroundColor:(nonnull UIColor *)backgroundColor borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment {
    return [self hz_setTextfieldWithFont:font textColor:textColor placeholder:placeholder backgroundColor:backgroundColor borderStyle:borderStyle textAlignment:textAlignment secureTextEntry:NO];
}

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder backgroundColor:(nonnull UIColor *)backgroundColor borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment secureTextEntry:(BOOL)secureTextEntry
{
    UITextField *textField = [[UITextField alloc] init];
    textField.font = font;
    textField.textColor = textColor;
    textField.placeholder = placeholder;
    textField.borderStyle = borderStyle;
    textField.backgroundColor = backgroundColor;
    textField.textAlignment = textAlignment;
    textField.secureTextEntry = secureTextEntry;
    return textField;
}

@end
