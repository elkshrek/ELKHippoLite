//
//  UITextField+HZAppearance.h
//  ELKHaiTouClient
//
//  Created by 黄子乐 on 2020/5/18.
//  Copyright © 2020 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (HZAppearance)

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor;

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *_Nullable)placeholder;

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor attributedPlaceholder:(NSAttributedString *)attributedPlaceholder;

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder backgroundColor:(UIColor *)backgroundColor;

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder backgroundColor:(UIColor *)backgroundColor  borderStyle:(UITextBorderStyle)borderStyle;

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder backgroundColor:(UIColor *)backgroundColor borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment;

+ (UITextField *)hz_setTextfieldWithFont:(UIFont *)font textColor:(UIColor *)textColor placeholder:(NSString *)placeholder backgroundColor:(UIColor *)backgroundColor  borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment secureTextEntry:(BOOL)secureTextEntry;


@end

NS_ASSUME_NONNULL_END
