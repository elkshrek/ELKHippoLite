//
//  UIButton+HZTouchControl.m
//  ObserveTest
//
//  Created by newmac on 2019/5/29.
//  Copyright © 2019 newmac. All rights reserved.
//

#import "UIButton+HZTouchControl.h"
#import <objc/runtime.h>

@interface UIButton()

@property (nonatomic, assign) BOOL hz_isSetupHighLightSelector;
@property (nonatomic, copy) void(^hz_touchHlightBlock)(UIButton *button, BOOL isHighlight);
@property (nonatomic, copy) void(^hz_touchUpInsideBlock)(UIButton *button);

@end

@implementation UIButton (HZTouchControl)

- (void)hz_setupTouchHighlightBlock:(void (^)(UIButton * _Nonnull, BOOL))block {
    [self hz_setupTouchControlSelectors];
    self.hz_touchHlightBlock = block;
}

- (void)hz_setupTouchUpInsideBlock:(void (^)(UIButton * _Nonnull))block {
    [self hz_setupTouchControlSelectors];
    self.hz_touchUpInsideBlock = block;
}

- (void)hz_setupTouchControlSelectors {
    if (!self.hz_isSetupHighLightSelector) {
        [self addTarget:self action:@selector(hz_handleTouchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(hz_handleTouchUp) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel | UIControlEventTouchDragOutside];
        [self addTarget:self action:@selector(hz_handleTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        self.hz_isSetupHighLightSelector = YES;
    }
}

- (void)hz_handleTouchUpInside {
    if (self.hz_touchUpInsideBlock) {
        self.hz_touchUpInsideBlock(self);
    }
}

- (void)hz_handleTouchDown {
    if (self.hz_touchHlightBlock) {
        self.hz_touchHlightBlock(self, YES);
    }
}

- (void)hz_handleTouchUp {
    if (self.hz_touchHlightBlock) {
        self.hz_touchHlightBlock(self, NO);
    }
}

- (void)setHz_isSetupHighLightSelector:(BOOL)hz_isSetupHighLightSelector {
    objc_setAssociatedObject(self, @selector(hz_isSetupHighLightSelector), @(hz_isSetupHighLightSelector), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hz_isSetupHighLightSelector
{
    return [objc_getAssociatedObject(self, @selector(hz_isSetupHighLightSelector)) boolValue];
}

- (void)setHz_touchHlightBlock:(void (^)(UIButton *, BOOL))hz_touchHlightBlock {
    objc_setAssociatedObject(self, @selector(hz_touchHlightBlock), hz_touchHlightBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton *, BOOL))hz_touchHlightBlock {
    return objc_getAssociatedObject(self, @selector(hz_touchHlightBlock));
}

- (void)setHz_touchUpInsideBlock:(void (^)(UIButton *))hz_touchUpInsideBlock {
    objc_setAssociatedObject(self, @selector(hz_touchUpInsideBlock), hz_touchUpInsideBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton *))hz_touchUpInsideBlock {
    return objc_getAssociatedObject(self, @selector(hz_touchUpInsideBlock));
}

@end
