//
//  UILabel+CKLAppearance.h
//  huangNew
//
//  Created by newmac on 2019/4/23.
//  Copyright © 2019 创客令所有权. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CKLAppearance)

- (void)applyLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor;

- (void)applyLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAlignment:(NSTextAlignment)textAlignment;

- (void)applyLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor;

- (void)applyLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor title:(NSString *)title;

- (void)applyLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor title:(NSString *_Nullable)title textAlignment:(NSTextAlignment)textAlignment cornerRadius:(NSInteger)cornerRadius;

@end

NS_ASSUME_NONNULL_END
