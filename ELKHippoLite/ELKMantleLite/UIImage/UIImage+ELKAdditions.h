//
//  UIImage+ELKAdditions.h
//  ELKCommonDemo
//
//  Created by wing on 2020/5/9.
//  Copyright © 2020 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ELKAdditions)



/// 根据颜色生成图片
/// @param iColor 颜色
+ (UIImage *)elk_imageWithColor:(UIColor *)iColor;



/// 根据视频url 获取第一帧图片
+ (UIImage *)elk_getFirstFrameImageWithUrl:(NSString *)videoURL;

/// 根据本地视频路径 获取第一帧图片
+ (UIImage *)elk_getFirstFrameImageWithfilePath:(NSString *)filePath;






@end

NS_ASSUME_NONNULL_END
