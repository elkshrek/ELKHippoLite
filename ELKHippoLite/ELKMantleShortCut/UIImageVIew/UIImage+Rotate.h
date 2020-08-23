//
//  UIImage+Rotate.h
//  UIImage+Categories
//
//  Created by lisong on 16/9/4.
//  Copyright © 2016年 lisong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotate)

/** 纠正图片的方向 */
- (UIImage *)elk_fixOrientation;

/** 按给定的方向旋转图片 */
- (UIImage*)elk_rotate:(UIImageOrientation)orient;

/** 垂直翻转 */
- (UIImage *)elk_flipVertical;

/** 水平翻转 */
- (UIImage *)elk_flipHorizontal;

/** 将图片旋转degrees角度 */
- (UIImage *)elk_imageRotatedByDegrees:(CGFloat)degrees;

/** 将图片旋转radians弧度 */
- (UIImage *)elk_imageRotatedByRadians:(CGFloat)radians;

@end
