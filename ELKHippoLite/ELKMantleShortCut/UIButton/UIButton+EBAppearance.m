//
//  UIButton+QMAppearance.m
//  Qiangmi
//
//  Created by EXphinx's Macbook Pro on 4/21/15.
//  Copyright (c) 2015 qiangmi.com. All rights reserved.
//

#import "UIButton+EBAppearance.h"
#import "UIImage+EBTintColor.h"

@implementation UIButton (EBAppearance)

- (void)setTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color forState:(UIControlState)state {
    [self setAttributedTitle:!title ? nil :
     [[NSAttributedString alloc] initWithString:title attributes:@{ NSForegroundColorAttributeName : color ? color : [UIColor blackColor], NSFontAttributeName : font ? font : [UIFont systemFontOfSize:15]}] forState:state];
}

- (void)setTitle:(NSString *)title color:(UIColor *)color forState:(UIControlState)state {
    [self setTitle:title font:[UIFont boldSystemFontOfSize:17] color:color forState:UIControlStateNormal];
}

- (void)eb_applyGenericStyle {
    [self eb_applyFontSize];
    [self eb_applyRoundCorner];
}

- (void)eb_applyRoundCorner {
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

- (void)eb_applyFontSize {
    [self setAttributedTitleAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] forState:UIControlStateNormal];
}

- (void)setAttributedTitleColor:(UIColor *)color forState:(UIControlState)state {
    if (!color) {
        color = [UIColor blackColor];
    }
    [self setAttributedTitleAttribute:NSForegroundColorAttributeName value:color forState:state];
}

- (void)setAttributedTitleAttribute:(NSString *)attributeName value:(id)value forState:(UIControlState)state {
    if (!value) {
        return;
    }
    
    NSMutableAttributedString *attrTitle = [[self attributedTitleForState:state] mutableCopy];
    if (!attrTitle) {
        NSString *title = [self titleForState:state];
        if (!title) {
            title = @"";
        }
        attrTitle = [[NSMutableAttributedString alloc] initWithString:title attributes:@{}];
    }
    [attrTitle addAttribute:attributeName value:value range:NSMakeRange(0, attrTitle.length)];
    [self setAttributedTitle:attrTitle forState:state];
}

- (void)eb_usingThemeWithBackgroundColor:(UIColor *)color {
    [self eb_applyGenericStyle];
//    self.layer.borderColor = [color CGColor];
//    self.layer.borderWidth = 1;
    [self setBackgroundImage:[UIImage imageWithSize:CGSizeMake(1, 1) color:color] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithSize:CGSizeMake(1, 1) color:[color colorWithAlphaComponent:0.8]] forState:UIControlStateHighlighted];
    [self setAttributedTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setAttributedTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];
}

- (void)eb_usingBorderThemeWithColor:(UIColor *)color {
    [self eb_applyGenericStyle];
    self.layer.borderColor = [[color colorWithAlphaComponent:0.8] CGColor];
    self.layer.borderWidth = 1;
    [self setAttributedTitleColor:color forState:UIControlStateNormal];
    [self setAttributedTitleColor:[color colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
}

@end
