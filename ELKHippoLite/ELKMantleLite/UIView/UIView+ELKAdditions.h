//
//  UIView+ELKAdditions.h
//  ELKCommonDemo
//
//  Created by wing on 2020/5/8.
//  Copyright © 2020 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//view圆角
typedef NS_OPTIONS(NSUInteger, ELKRectCornerType) {
    ELKRectCornerTopLeftRight      = 1 << 0,//!< 左上_右上_角为圆角.
    ELKRectCornerBottomLeftRight   = 1 << 1,  //!< 左下_右下_角设圆角.
    ELKRectCornerTopLeft     = 1 << 2,  //!< 左下_右下_角设圆角.
    ELKRectCornerTopRight    = 1 << 3,  //!< 左下_右下_角设圆角.
    ELKRectCornerBottomLeft  = 1 << 4,  //!< 左下_右下_角设圆角.
    ELKRectCornerBottomRight  = 1 << 5,  //!< 左下_右下_角设圆角.
    ELKRectCornerAllCorners  = ~0UL
};


@interface UIView (ELKAdditions)

#pragma mark - 添加阴影边框
- (void)elk_addShadowColor:(UIColor *)shadowColor offSet:(CGSize)offset opacity:(CGFloat)opacity;
- (void)elk_addShadowColor:(UIColor *)shadowColor offSet:(CGSize)offset opacity:(CGFloat)opacity shadowRadius:(CGFloat)radius;
#pragma mark - 设置圆角

/// 设置圆角
/// @param styleType type
/// @param cornerRadii 圆角
- (void)elk_maskCornerWithStyleType:(ELKRectCornerType)styleType cornerRadii:(CGFloat)cornerRadii;
 





@end

NS_ASSUME_NONNULL_END
