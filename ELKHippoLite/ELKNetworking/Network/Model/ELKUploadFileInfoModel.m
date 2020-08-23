//
//  ELKUploadFileInfoModel.m
//  ELKCommonDemo
//
//  Created by wing on 2020/6/18.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKUploadFileInfoModel.h"
#import "ELKMacroLite.h"

@interface ELKUploadFileInfoModel ()

/// 文件在服务器的相对位置  默认：picture/
@property (nonatomic, copy) NSString *filePath;
/// 文件数据 UIImage | AVAsset | 图片的Data数据
@property (nonatomic, strong) id fileData;

@end

@implementation ELKUploadFileInfoModel

/// 文件数据信息
/// @param fileData 文件数据 UIImage(图片) | AVAsset(视频) | NSData(图片的Data数据)
/// @param filePath 文件相对位置  默认：picture/
+ (instancetype)elk_fileInfo:(id)fileData path:(NSString *_Nullable)filePath
{
    ELKUploadFileInfoModel *fileInfo = [[ELKUploadFileInfoModel alloc] init];
    fileInfo.filePath = [stdString(filePath) length] ? stdString(filePath) : @"picture/";
    fileInfo.fileData = fileData;
    
    return fileInfo;
}


@end
