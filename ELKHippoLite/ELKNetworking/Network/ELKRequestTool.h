//
//  ELKNetworkRequest.h
//  ELKParallel
//
//  Created by wing on 2020/3/18.
//  Copyright © 2020 wing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELKNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELKRequestTool : NSObject


/// post网络请求
/// @param apiUrl    接口
/// @param params    请求参数
/// @param success   成功反馈
/// @param failure   失败反馈
+ (void)elk_post:(nullable NSString *)apiUrl param:(nullable NSDictionary *)params success:(void (^)(id _Nonnull feedback, BOOL status))success failure:(void (^)(NSError * _Nonnull error))failure;



/// 自己服务器上传图片
/// @param image   图片信息 [UIImage | NSData]
/// @param params  附加参数
/// @param success 成功反馈
/// @param failure 失败反馈
+ (void)elk_upload:(nonnull id)image params:(nullable NSDictionary *)params success:(void(^_Nonnull)(NSString *_Nonnull imgUrlString, BOOL status))success failure:(void(^_Nonnull)(NSError *_Nullable error))failure;



/// 阿里OSS文件服务器上传图片
/// @param fileData  ELKUploadFileInfoModel对象
/// @param progress  上传进度反馈
/// @param success   成功反馈 imgUrlString：图片地址 status 是否成功
/// @param failure   失败反馈
+ (void)elk_ossUpload:(ELKUploadFileInfoModel *_Nonnull)fileData progress:(ELKNetRespProgress)progress success:(void(^_Nonnull)(NSString *_Nonnull mediaUrl, BOOL status))success failure:(void(^_Nonnull)(NSError *_Nullable error))failure;





@end

NS_ASSUME_NONNULL_END
