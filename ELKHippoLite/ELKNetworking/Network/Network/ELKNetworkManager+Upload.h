//
//  ELKNetworkManager+Upload.h
//  ELKHippoLite
//
//  Created by Jonathan on 2019/4/18.
//  Copyright © 2019 elk. All rights reserved.
//

#import "ELKNetworkManager.h"
#import "ELKAliOSSInfoModel.h"
#import "ELKUploadFileInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELKNetworkManager (Upload)


/// 上传图片
/// @param urlString 完整文件服务器地址
/// @param image     图片信息 [UIImage | NSData]
/// @param params    附加参数
/// @param success   成功反馈
/// @param failure   失败反馈
+ (void)elk_uploadImageUrl:(NSString *)urlString image:(nonnull id)image params:(nullable NSDictionary *)params success:(ELKNetRespOxygen)success failure:(ELKNetRespFailure)failure;



/// 阿里OSS文件上传: UIImage(图片) | AVAsset(视频) | NSData(图片的Data数据)
/// @param aliOSSInfo OSS Upload 信息
/// @param fileData   ELKUploadFileInfoModel对象
/// @param progress   上传进度反馈
/// @param success    成功反馈 imgUrlString：图片地址 status 是否成功
/// @param failure    失败反馈
+ (void)elk_aliOSSUpload:(ELKAliOSSInfoModel *)aliOSSInfo file:(ELKUploadFileInfoModel *_Nonnull)fileData progress:(ELKNetRespProgress)progress success:(ELKNetRespOxygen)success failure:(ELKNetRespFailure)failure;





@end

NS_ASSUME_NONNULL_END
