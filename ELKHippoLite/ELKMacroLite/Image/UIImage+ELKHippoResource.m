//
//  UIImage+ELKHippoResource.m
//  ELKHippoLite
//
//  Created by wing on 2020/5/8.
//  Copyright © 2020 wing. All rights reserved.
//

#import "UIImage+ELKHippoResource.h"

@implementation UIImage (ELKHippoResource)


/// 根据图片名获取Hippo资源图片
/// @param imageName  图片名
/// @param bundleName 图片所在bundle名
+ (UIImage *)elk_hippoImageNamed:(NSString *)imageName inBundle:(NSString *_Nonnull)bundleName;
{
    NSBundle *hippoBundle = [UIImage elk_hippoResBundle:bundleName];
    UIImage *image = [UIImage imageNamed:imageName inBundle:hippoBundle compatibleWithTraitCollection:nil];
    return image;
}


+ (NSBundle *)elk_hippoResBundle:(NSString *)bundleName
{
    static NSBundle *hippoBundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *mainBundle = [NSBundle mainBundle];
        hippoBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:bundleName ofType:@"bundle"]];
        if (hippoBundle == nil) {
            hippoBundle = mainBundle;
        }
    });
    return hippoBundle;
}


@end
