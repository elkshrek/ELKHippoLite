//
//  UIImage+VPTintColor.h
//  VIP800
//
//  Created by EXphinx's Macbook Pro on 12/17/13.
//  Copyright (c) 2013 EB.CN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EBTintColor)
- (UIImage *)elk_imageWithTintColor:(UIColor *)color;
- (UIImage *)imageWithAlphaComponent:(CGFloat)alpha;

+ (UIImage *)emptyImageWithSize:(CGSize)size;
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color;

+ (UIImage *)barButtonBackgroundImageWithBorderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)barButtonBackgroundImageWithBorderColor:(UIColor *)borderColor fillColor:(UIColor *)fillColor cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)segmentedControlBackgroundImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)segmentedControlSelectedBackgroundImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)segmentedControlDividerImageWithColor:(UIColor *)color;

+ (UIImage *)roundedRectBorderImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor borderWidth:(CGFloat)borderWidth color:(UIColor *)borderColor;
+ (UIImage *)roundedRectBorderImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor borderWidth:(CGFloat)borderWidth edgeInsets:(UIEdgeInsets)edgeInsets color:(UIColor *)borderColor;

+ (UIImage *)backButtonImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor borderWidth:(CGFloat)borderWidth color:(UIColor *)borderColor;
+ (UIImage *)backButtonImageWithCornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor borderWidth:(CGFloat)borderWidth color:(UIColor *)borderColor;

@end
