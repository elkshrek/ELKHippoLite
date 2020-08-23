//
//  UIImage+ELKHippoResource.h
//  ELKHippoLite
//
//  Created by wing on 2020/5/8.
//  Copyright © 2020 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ELKHippoResource)


/// 根据图片名获取Hippo资源图片
/// @param imageName  图片名
/// @param bundleName 图片所在bundle名
+ (UIImage *)elk_hippoImageNamed:(NSString *)imageName inBundle:(NSString *_Nonnull)bundleName;



@end

NS_ASSUME_NONNULL_END
