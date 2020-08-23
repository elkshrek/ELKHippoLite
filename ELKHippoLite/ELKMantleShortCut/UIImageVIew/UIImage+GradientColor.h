//
//  UIImage+GradientColor.h
//  huangNew
//
//  Created by newmac on 2019/5/9.
//  Copyright © 2019 chuangke.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GradientColor)

+ (UIImage *)elk_imageWithSize:(CGSize)size colors:(NSArray *)colors;
+ (UIImage *)elk_imageWithSize:(CGSize)size colors:(NSArray *)colors endPoint:(CGPoint)endPoint;
+ (UIImage *)elk_imageWithSize:(CGSize)size colors:(NSArray *)colors starPoint:(CGPoint)startPoint locations:(NSArray *_Nullable)locations endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
