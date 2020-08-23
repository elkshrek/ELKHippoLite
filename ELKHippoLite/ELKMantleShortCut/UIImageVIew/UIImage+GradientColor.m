//
//  UIImage+GradientColor.m
//  huangNew
//
//  Created by newmac on 2019/5/9.
//  Copyright © 2019 chuangke.com. All rights reserved.
//

#import "UIImage+GradientColor.h"

@implementation UIImage (GradientColor)

+ (UIImage *)elk_imageWithSize:(CGSize)size colors:(NSArray *)colors
{
    UIImage *image = [self elk_imageWithSize:size colors:colors endPoint:CGPointMake(1, 0)];
    return image;
}

+ (UIImage *)elk_imageWithSize:(CGSize)size colors:(NSArray *)colors endPoint:(CGPoint)endPoint
{
    UIImage *image = [self elk_imageWithSize:size colors:colors starPoint:CGPointMake(0, 1) locations:nil endPoint:endPoint];
    return image;
}

+ (UIImage *)elk_imageWithSize:(CGSize)size colors:(NSArray *)colors starPoint:(CGPoint)startPoint locations:(NSArray *)locations endPoint:(CGPoint)endPoint
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, size.width, size.height);
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    gradient.locations = locations;
    gradient.colors = colors;
    
    UIGraphicsBeginImageContextWithOptions(gradient.frame.size, NO, 0);
    [gradient renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
