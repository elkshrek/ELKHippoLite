//
//  ELKAliOSSInfoModel.h
//  ELKCommonDemo
//
//  Created by wing on 2020/6/1.
//  Copyright © 2020 wing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 阿里OSS服务 需要的信息 {accessKey,secretKey,endPoint,bucketName,path}
@interface ELKAliOSSInfoModel : NSObject

/// accessKey
@property (nonatomic, copy, readonly) NSString *accessKey;
/// secretKey
@property (nonatomic, copy, readonly) NSString *secretKey;
/// endPoint 默认为：https://oss-cn-beijing.aliyuncs.com
@property (nonatomic, copy, readonly) NSString *endPoint;
/// bucketName 默认为：efei
@property (nonatomic, copy, readonly) NSString *bucketName;


/// AliOSS服务基础信息
/// @param accessKey    accessKey
/// @param secretKey    secretKey
/// @param endPoint     endPoint 可以为空，默认：https://oss-cn-beijing.aliyuncs.com
/// @param bucketName   bucketName 可以为空，默认：efei
+ (instancetype)elk_aliOSSAccess:(NSString *_Nonnull)accessKey secret:(NSString *_Nonnull)secretKey endPoint:(NSString *_Nullable)endPoint bucket:(NSString *_Nullable)bucketName;


/// 请使用：elk_aliOSSAccess:secret:endPoint:bucket:path:
- (instancetype)init NS_UNAVAILABLE;
/// 请使用：elk_aliOSSAccess:secret:endPoint:bucket:path:
+ (instancetype)new NS_UNAVAILABLE;


@end

NS_ASSUME_NONNULL_END
