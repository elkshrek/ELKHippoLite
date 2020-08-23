//
//  ELKAliOSSInfoModel.m
//  ELKCommonDemo
//
//  Created by wing on 2020/6/1.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKAliOSSInfoModel.h"
#import "ELKMacroLite.h"

@interface ELKAliOSSInfoModel ()

/// accessKey
@property (nonatomic, copy) NSString *accessKey;
/// secretKey
@property (nonatomic, copy) NSString *secretKey;
/// endPoint 默认为：https://oss-cn-beijing.aliyuncs.com
@property (nonatomic, copy) NSString *endPoint;
/// bucketName 默认为：efei
@property (nonatomic, copy) NSString *bucketName;


@end

@implementation ELKAliOSSInfoModel


/// AliOSS服务基础信息
/// @param accessKey    accessKey
/// @param secretKey    secretKey
/// @param endPoint     endPoint 可以为空，默认：https://oss-cn-beijing.aliyuncs.com
/// @param bucketName   bucketName 可以为空，默认：efei
+ (instancetype)elk_aliOSSAccess:(NSString *_Nonnull)accessKey secret:(NSString *_Nonnull)secretKey endPoint:(NSString *_Nullable)endPoint bucket:(NSString *_Nullable)bucketName
{
    ELKAliOSSInfoModel *aliOSSInfo = [[ELKAliOSSInfoModel alloc] init];
    aliOSSInfo.accessKey = stdString(accessKey);
    aliOSSInfo.secretKey = stdString(secretKey);
    aliOSSInfo.endPoint = [stdString(endPoint) length] ? stdString(endPoint) : @"https://oss-cn-beijing.aliyuncs.com";
    aliOSSInfo.bucketName = [stdString(bucketName) length] ? stdString(bucketName) : @"efei";
    
    return aliOSSInfo;
}



@end
