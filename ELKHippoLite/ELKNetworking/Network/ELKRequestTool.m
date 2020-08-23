//
//  ELKRequestTool.m
//  ELKParallel
//
//  Created by wing on 2020/3/18.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKRequestTool.h"
#import "ELKAccountTool.h"
#import "ELKMacroLite.h"
#import <SVProgressHUD/SVProgressHUD.h>


@implementation ELKRequestTool


/// post网络请求
/// @param apiUrl    接口
/// @param params    请求参数
/// @param success   成功反馈
/// @param failure   失败反馈
+ (void)elk_post:(nullable NSString *)apiUrl param:(nullable NSDictionary *)params success:(void (^)(id _Nonnull feedback, BOOL status))success failure:(void (^)(NSError * _Nonnull error))failure
{
    BOOL needEncry = [apiUrl hasPrefix:@"s-"];
    
    [ELKNetworkManager elk_postWithUrl:apiUrl parameter:params needEncry:needEncry success:^(id _Nonnull feedback, BOOL status) {
        if (success) {
            success(feedback, status);
        }
        if (!status) {
            NSInteger errCode = [stdNumber(feedback[@"errCode"]) integerValue];
            // todoooooo 登录 token 过期 | 其他登录失效状态
            if (errCode == 301) {
                // 触发登录失效回调
                [ELKNetworkManager elk_touchLostLogin];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}



/// 上传图片
+ (void)elk_upload:(nonnull id)image params:(nullable NSDictionary *)params success:(void(^_Nonnull)(NSString *_Nonnull imgUrlString, BOOL status))success failure:(void(^_Nonnull)(NSError *_Nullable error))failure
{
    [ELKNetworkManager elk_uploadImage:image params:params success:success failure:failure];
}


/// 阿里OSS文件服务器上传图片
+ (void)elk_ossUpload:(ELKUploadFileInfoModel *)fileData progress:(ELKNetRespProgress)progress success:(void (^)(NSString * _Nonnull, BOOL))success failure:(void (^)(NSError * _Nullable))failure
{
    [SVProgressHUD showWithStatus:@"上传中..."];
    [ELKNetworkManager elk_ossUpload:fileData progress:progress success:^(NSString * _Nonnull resString, BOOL status) {
        if (status) {
            [SVProgressHUD dismiss];
        } else {
            [SVProgressHUD showErrorWithStatus:resString];
        }
        if (success) {
            success(resString, status);
        }
    } failure:^(NSError * _Nullable error) {
        [SVProgressHUD showErrorWithStatus:@"上传失败，请重试"];
        if (failure) {
            failure(error);
        }
    }];
    
}







@end
