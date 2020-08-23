//
//  UIImage+ELKAdditions.m
//  ELKCommonDemo
//
//  Created by wing on 2020/5/9.
//  Copyright © 2020 wing. All rights reserved.
//

#import "UIImage+ELKAdditions.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (ELKAdditions)



/// 根据颜色生成图片
/// @param iColor 颜色
+ (UIImage *)elk_imageWithColor:(UIColor *)iColor
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [iColor CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


/// 根据视频url 获取第一帧图片
+ (UIImage *)elk_getFirstFrameImageWithUrl:(NSString *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    NSTimeInterval time = 0.1;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError*error = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime,60) actualTime:NULL error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    if (thumbnailImageRef) {
        return [[UIImage alloc] initWithCGImage:thumbnailImageRef];
    }
    return nil;
}

/// 根据本地视频路径 获取第一帧图片
+ (UIImage *)elk_getFirstFrameImageWithfilePath:(NSString *)filePath
{
    NSURL *sourceURL = [NSURL fileURLWithPath:filePath];
    AVAsset *asset = [AVAsset assetWithURL:sourceURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMake(0, 1);
    NSError *error;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbnail;
}





@end
