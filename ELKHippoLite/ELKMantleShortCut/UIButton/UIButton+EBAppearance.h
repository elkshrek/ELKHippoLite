//
//  UIButton+QMAppearance.h
//  Qiangmi
//
//  Created by EXphinx's Macbook Pro on 4/21/15.
//  Copyright (c) 2015 qiangmi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EBAppearance)

- (void)setTitle:(NSString *)title color:(UIColor *)color forState:(UIControlState)state;
- (void)setTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color forState:(UIControlState)state;
- (void)setAttributedTitleColor:(UIColor *)color forState:(UIControlState)state;

- (void)eb_usingThemeWithBackgroundColor:(UIColor *)color;
- (void)eb_usingBorderThemeWithColor:(UIColor *)color;

//- (void)qm_usingDestructiveTheme;
//- (void)qm_usingWarningTheme;

@end
