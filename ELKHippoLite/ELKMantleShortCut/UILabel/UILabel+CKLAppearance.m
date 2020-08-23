//
//  UILabel+CKLAppearance.m
//  huangNew
//
//  Created by newmac on 2019/4/23.
//  Copyright © 2019 创客令所有权. All rights reserved.
//

#import "UILabel+CKLAppearance.h"

@implementation UILabel (CKLAppearance)

- (void)applyLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    [self applyLabelWithFont:font textColor:textColor backgroundColor:[UIColor clearColor]];
}

- (void)applyLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor {
    [self applyLabelWithFont:font textColor:textColor backgroundColor:backgroundColor textAlignment:NSTextAlignmentLeft];
}

- (void)applyLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor title:(NSString *)title {
    [self applyLabelWithFont:font textColor:textColor backgroundColor:backgroundColor title:title textAlignment:NSTextAlignmentLeft cornerRadius:0];
}

- (void)applyLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor textAlignment:(NSTextAlignment)textAlignment {
    [self applyLabelWithFont:font textColor:textColor backgroundColor:backgroundColor title:nil textAlignment:textAlignment cornerRadius:0];
}

- (void)applyLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor title:(NSString *_Nullable)title textAlignment:(NSTextAlignment)textAlignment cornerRadius:(NSInteger)cornerRadius
{
    self.font = font;
    self.textColor = textColor;
    self.backgroundColor = backgroundColor;
    self.textAlignment = textAlignment;
    if (cornerRadius > 0) {
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
    }
}


@end
