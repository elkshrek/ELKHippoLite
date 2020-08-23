//
//  ELKNetworkManager.h
//  ELKHippoLite
//
//  Created by Jonathan on 2019/4/18.
//  Copyright © 2019 elk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ELKNetStatusMaster.h"
#import "Encryption.h"
#import "NSData+AES256.h"
#import "NSString+MD5.h"
#import "NSString+SHA1.h"
#import "ELKAliOSSInfoModel.h"
#import "ELKUploadFileInfoModel.h"
#import "ELKAccountTool.h"

/// --------- Block ---------------------
/// 网络请求反馈Block 成功
typedef void(^ELKNetRespSuccess)(id _Nonnull feedback, BOOL status);
/// 网络请求反馈Block 失败
typedef void(^ELKNetRespFailure)(NSError *_Nullable error);
/// 网络请求反馈Block 结果状态
typedef void(^ELKNetRespResult)(BOOL status);
/// 网络请求反馈Block 字符串结果
typedef void(^ELKNetRespOxygen)(NSString *_Nonnull resString, BOOL status);
/// 网络上传文件 当前进度反馈
typedef void(^ELKNetRespProgress)(CGFloat progress);
/// 网络请求反馈Block 抛出登录失效状态
typedef void(^ELKNetRespLostLogin)(void);


/// 请求方式
typedef NS_OPTIONS(NSUInteger, ELK_NetReqMethod) {
    /// post
    ELK_ReqPost    = 1 << 0,
    /// get
    ELK_ReqGet     = 1 << 1,
};
///  加解密状态
typedef NS_OPTIONS(NSUInteger, ELK_NetAESCryptType) {
    /// 开启加解密 默认
    ELK_AESTypeEnable  = 1 << 0,
    /// 关闭加解密
    ELK_AESTypeDisable = 1 << 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface ELKNetworkManager : NSObject

#pragma mark - 接口服务器
/// 设置接口服务器地址
/// @param hostUrl  接口服务器地址
+ (void)elk_setHostUrl:(NSString *)hostUrl;

/// post网络请求
/// @param urlStr    网络地址
/// @param params    参数
/// @param needEncry 是否需要加密
/// @param success   成功
/// @param failure   失败
+ (void)elk_postWithUrl:(NSString *_Nonnull)urlStr parameter:(nullable NSDictionary *)params needEncry:(BOOL)needEncry success:(ELKNetRespSuccess)success failure:(ELKNetRespFailure)failure;

/// 触发登录失效事件
+ (void)elk_touchLostLogin;
/// 捕获接口调用过程中登录失效的状态
/// @param lostLogin  登录失效反馈
+ (void)elk_catchLostLogin:(ELKNetRespLostLogin)lostLogin;


#pragma mark - 自己文件服务器
/// 设置文件服务器地址
/// @param fileHost 文件服务器地址
+ (void)elk_setFileHost:(NSString *)fileHost;
/// 自己服务器上传图片
/// @param image   图片信息 [UIImage | NSData]
/// @param params  附加参数
/// @param success 成功反馈 resString：图片地址 status 是否成功
/// @param failure 失败反馈
+ (void)elk_uploadImage:(nonnull id)image params:(nullable NSDictionary *)params success:(ELKNetRespOxygen)success failure:(ELKNetRespFailure)failure;


#pragma mark - 阿里OSSUpload图片上传
/// 使用阿里OSSUpload前，请先设置OSS信息
/// @param aliOSSInfo  阿里OSS Upload基础信息
+ (void)elk_setAliOSSInfo:(ELKAliOSSInfoModel *)aliOSSInfo;
/// 阿里OSS上传图片
/// @param fileData ELKUploadFileInfoModel对象
/// @param progress 上传进度反馈
/// @param success  成功反馈 imgUrlString：图片地址 status 是否成功
/// @param failure  失败反馈
+ (void)elk_ossUpload:(ELKUploadFileInfoModel *_Nonnull)fileData progress:(ELKNetRespProgress)progress success:(ELKNetRespOxygen)success failure:(ELKNetRespFailure)failure;



#pragma mark - 加密开关 加密密匙
/// 设置加密开关|参数加密状态
+ (void)elk_setCryptStatus:(ELK_NetAESCryptType)cryptType;
/// 当前是否开启加解密 YES OR NO
+ (BOOL)elk_cryptStatus;

/// 设置加密密匙
/// @param userToken 密匙
+ (void)elk_setUserToken:(NSString *)userToken;
/// 获取加密匙
+ (NSString *)elk_getUserToken;

/// 清除登录的信息
+ (void)elk_clearLoginInfo;

/// 取SESSION
+ (NSString *)elk_getCookie;



@end

NS_ASSUME_NONNULL_END
