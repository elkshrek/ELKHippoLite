//
//  UIView+HZBorderLine.m
//  ObserveTest
//
//  Created by newmac on 2019/6/3.
//  Copyright © 2019 newmac. All rights reserved.
//

#import "UIView+HZBorderLine.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

@implementation UIView (HZBorderLine)

- (void)setHz_borderEdge:(UIRectEdge)hz_borderEdge {
    objc_setAssociatedObject(self, @selector(hz_borderEdge), @(hz_borderEdge), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self hz_updateBorderLineViewForEdge:hz_borderEdge];
    [self hz_borderLineViewToFont];
}

- (UIRectEdge)hz_borderEdge {
    return [objc_getAssociatedObject(self, @selector(hz_borderEdge)) integerValue];
}

- (void)setHz_isLineOutside:(BOOL)hz_isLineOutside {
    BOOL outSide = [self hz_isLineOutside];
    objc_setAssociatedObject(self, @selector(hz_isLineOutside), @(hz_isLineOutside), OBJC_ASSOCIATION_ASSIGN);
    if (outSide != hz_isLineOutside) {
        [self hz_updateBorderLineViewForEdge:self.hz_borderEdge];
    }
}

- (BOOL)hz_isLineOutside
{
    return [objc_getAssociatedObject(self, @selector(hz_isLineOutside)) boolValue];
}

- (void)setHz_borderlineColor:(UIColor *)hz_borderlineColor {
    objc_setAssociatedObject(self, @selector(hz_borderlineColor), hz_borderlineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self hz_borderlineColor];
}

- (UIColor *)hz_borderlineColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(hz_borderlineColor));
    if (!color) {
        color = [UIColor colorWithWhite:0.95 alpha:1.0];
    }
    return color;
}

- (CGFloat)hz_leftMargin {
    return [objc_getAssociatedObject(self, @selector(hz_leftMargin)) floatValue];
}

- (void)setHz_leftMargin:(CGFloat)hz_leftMargin {
    objc_setAssociatedObject(self, @selector(hz_leftMargin), @(hz_leftMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self hz_updateBorderLineViewForEdge:self.hz_borderEdge];
}

- (void)setHz_rightMargin:(CGFloat)hz_rightMargin {
    objc_setAssociatedObject(self, @selector(hz_rightMargin), @(hz_rightMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self hz_updateBorderLineViewForEdge:self.hz_borderEdge];
}

- (CGFloat)hz_rightMargin {
    return [objc_getAssociatedObject(self, @selector(hz_rightMargin)) floatValue];
}

- (NSMutableDictionary *)hz_borderLineViews {
    NSMutableDictionary *views = objc_getAssociatedObject(self, @selector(hz_borderLineViews));
    if (!views) {
        views = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(hz_borderLineViews), views, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return views;
}

- (void)hz_updateBorderLineViewForEdge:(UIRectEdge)rectEdge {
    for (NSUInteger i = 0; i < 4; i++) {
        UIRectEdge edge = 1 << i;
        if (edge & rectEdge) {
            [self hz_addBorderLineViewIfNeed:edge];
        } else {
            [self hz_removeBorderLineViewIfNeed:edge];
        }
    }
    [self setNeedsLayout];
}

- (void)hz_addBorderLineViewIfNeed:(UIRectEdge)rectEdge {
    UIView *lineView = [self hz_borderLineViews][@(rectEdge)];
    if (!lineView) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = self.hz_borderlineColor;
        [[self hz_borderLineViews] setObject:lineView forKey:@(rectEdge)];
        [self addSubview:lineView];
        [self hz_layoutBorderLineView:lineView rectEdge:rectEdge];
    } else {
        [self hz_layoutBorderLineView:lineView rectEdge:rectEdge];
    }
}

- (void)hz_removeBorderLineViewIfNeed:(UIRectEdge)rectEdge {
    UIView *lineView = [self hz_borderLineViews][@(rectEdge)];
    if (lineView) {
        [lineView removeFromSuperview];
        [[self hz_borderLineViews] removeObjectForKey:@(rectEdge)];
    }
}

- (void)hz_layoutBorderLineView:(UIView *)lineView rectEdge:(UIRectEdge)rectEdge
{
    CGFloat width = 1.0 / [[UIScreen mainScreen] scale];
    BOOL isOutSide = self.hz_isLineOutside;
    CGFloat leftMargin = self.hz_leftMargin;
    CGFloat rightMargin = self.hz_rightMargin;
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        switch (rectEdge) {
            case UIRectEdgeLeft: {
                make.top.bottom.equalTo(self);
                make.width.equalTo(@(width));
                if (isOutSide) {
                    make.right.equalTo(self);
                } else {
                    make.left.equalTo(self);
                }
            }
                break;
            case UIRectEdgeRight: {
                make.top.bottom.equalTo(self);
                make.width.equalTo(@(width));
                if (isOutSide) {
                    make.left.equalTo(self);
                } else {
                    make.right.equalTo(self);
                }
            }
                break;
            case UIRectEdgeTop: {
                make.right.equalTo(self).with.offset(-rightMargin);
                make.left.equalTo(self).with.offset(leftMargin);
                make.height.equalTo(@(width));
                if (isOutSide) {
                    make.bottom.equalTo(self);
                } else {
                    make.top.equalTo(self);
                }
            }
                break;
            case UIRectEdgeBottom: {
                make.right.equalTo(self).with.offset(-rightMargin);
                make.left.equalTo(self).with.offset(leftMargin);
                make.height.equalTo(@(width));
                if (isOutSide) {
                    make.top.equalTo(self);
                } else {
                    make.bottom.equalTo(self);
                }
            }
                break;
            default:
                break;
        }
    }];
    
}

- (void)hz_borderLineViewToFont {
    for (id key in [self hz_borderLineViews]) {
        UIView *line = [self hz_borderLineViews][key];
        if (line.superview == self) {
            [self bringSubviewToFront:line];
        }
    }
}

- (void)hz_updateLineViewColor {
    for (id key in [self hz_borderLineViews]) {
        UIView *line = [self hz_borderLineViews][key];
        if (line.superview == self) {
            line.backgroundColor = self.hz_borderlineColor;
        }
    }
}

- (void)didMoveToSuperview {
    [self hz_borderLineViewToFont];
}

@end
