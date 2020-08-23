//
//  ELKUploadFileInfoModel.h
//  ELKCommonDemo
//
//  Created by wing on 2020/6/18.
//  Copyright © 2020 wing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 上传文件的数据信息
@interface ELKUploadFileInfoModel : NSObject

/// 文件在服务器的相对位置  默认：picture/
@property (nonatomic, copy, readonly) NSString *filePath;
/// 文件数据 UIImage(图片) | AVAsset(视频) | NSData(图片的Data数据)
@property (nonatomic, strong, readonly) id fileData;


/// 文件数据信息
/// @param fileData 文件数据 UIImage(图片) | AVAsset(视频) | NSData(图片的Data数据)
/// @param filePath 文件相对位置  默认：picture/
+ (instancetype)elk_fileInfo:(id)fileData path:(NSString *_Nullable)filePath;

/// 请使用：elk_fileInfo:path:
- (instancetype)init NS_UNAVAILABLE;
/// 请使用：elk_fileInfo:path:
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
