//
//  UITextField+ELKPlaceHolder.m
//  ELKParallel
//
//  Created by wing on 2019/10/23.
//  Copyright © 2019 elk. All rights reserved.
//

#import "UITextField+ELKPlaceHolder.h"
#import <objc/runtime.h>


@implementation UITextField (ELKPlaceHolder)

/// 设置placeHolder Color
/// @param placeColor place Color
- (void)elk_setPlaceHolderColor:(UIColor *)placeColor
{
    if (@available(iOS 13.0, *)) {
        Ivar ivar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(self, ivar);
        placeholderLabel.textColor = placeColor;
    } else {
        [self setValue:placeColor forKeyPath:@"_placeholderLabel.textColor"];
    }
}





@end
