//
//  ELKNetworkManager.m
//  ELKHippoLite
//
//  Created by Jonathan on 2019/4/18.
//  Copyright © 2019 elk. All rights reserved.
//

#import "ELKNetworkManager.h"
#import "ELKNetworkManager+Upload.h"
#import <AFNetworking/AFNetworking.h>
#import "ELKMacroLite.h"

@interface ELKNetworkManager ()

/// 接口服务器地址
@property (nonatomic, copy) NSString *hostUrl;
/// 文件服务器地址
@property (nonatomic, copy) NSString *fileHost;
// token 加解密用 密钥
@property (nonatomic, copy) NSString *userToken;
// SESSION
@property (nonatomic, copy) NSString *userCookie;
// 加解密开关
@property (nonatomic, assign) ELK_NetAESCryptType cryptType;

/// 阿里OSS服务信息
@property (nonatomic, strong) ELKAliOSSInfoModel *aliOSSInfo;

@property (nonatomic, copy) ELKNetRespLostLogin elkLostLogin;


@end

@implementation ELKNetworkManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cryptType = ELK_AESTypeEnable;
    }
    return self;
}

+ (instancetype)defaultManager
{
    static ELKNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ELKNetworkManager alloc] init];
    });
    return manager;
}

#pragma mark - 接口服务器
/// 设置接口服务器地址
+ (void)elk_setHostUrl:(NSString *)hostUrl
{
    [ELKNetworkManager defaultManager].hostUrl = hostUrl;
}
+ (NSString *)elk_getHostUrl
{
    return [ELKNetworkManager defaultManager].hostUrl ?: @"";
}
/// post网络请求
+ (void)elk_postWithUrl:(NSString *)urlStr parameter:(NSDictionary *)params needEncry:(BOOL)needEncry success:(ELKNetRespSuccess)success failure:(ELKNetRespFailure)failure
{
    if ([urlStr isEqualToString:@"NotFound"]) {
        if (success) {
            NSDictionary *resp = @{@"code":@0,
                                   @"errCode":@404,
                                   @"errMsg":@"接口未定义"};
            success(resp, NO);
        }
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    NSDictionary *reqParams = params;
    if (!params) {
        reqParams = @{};
    }
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", [ELKNetworkManager elk_getHostUrl], urlStr];
    NSMutableURLRequest *request = [self requestUrl:requestUrl method:ELK_ReqPost];
    NSData *paramsData = [self elk_paramsFormat:reqParams encry:needEncry];
    [request setHTTPBody:paramsData];
    
    [[manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
            NSDictionary *headerFile = httpResp.allHeaderFields;
            if (headerFile) {
                NSString *cookieStr = stdString(headerFile[@"Set-Cookie"]);
                [ELKNetworkManager defaultManager].userCookie = cookieStr;
            }
            NSLog(@"Network headerFile : %@", headerFile);
            
            NSDictionary *resDict = [self elk_respDataSerializa:responseObject];
            
            NSString *result = [NSString stringWithFormat:@"%@", resDict[@"code"]];
            if ([result isEqualToString:@"1"]) {
                if (success) {
                    success(resDict, YES);
                }
            } else {
                if (success) {
                    success(resDict, NO);
                }
            }
            NSLog(@"\n**************** Network Begin ****************");
            NSLog(@"hostUrl: %@ \nparameter: %@", requestUrl, reqParams);
            NSLog(@"**************** Network Response ****************");
            NSLog(@"hostUrl: %@ \nresponse: %@", requestUrl, resDict);
            NSLog(@"**************** Network End ****************\n");
        } else {
            NSLog(@"\n**************** Network Begin ****************");
            NSLog(@"hostUrl: %@ \nparameter: %@", requestUrl, reqParams);
            NSLog(@"**************** Network Response ****************");
            NSLog(@"hostUrl: %@ \nresponse: 请求失败 \nerror: %@", requestUrl, error);
            NSLog(@"**************** Network End ****************\n");
            if (failure) {
                failure(error);
            }
        }
    }] resume];
    
}

/// 触发登录失效事件
+ (void)elk_touchLostLogin
{
    if ([ELKNetworkManager defaultManager].elkLostLogin) {
        [ELKNetworkManager defaultManager].elkLostLogin();
    }
}
/// 捕获接口调用过程中登录失效的状态
/// @param lostLogin  登录失效反馈
+ (void)elk_catchLostLogin:(ELKNetRespLostLogin)lostLogin
{
    [ELKNetworkManager defaultManager].elkLostLogin = lostLogin;
}

#pragma mark - 自己文件服务器
/// 设置文件服务器地址
+ (void)elk_setFileHost:(NSString *)fileHost
{
    [ELKNetworkManager defaultManager].fileHost = fileHost;
}
+ (NSString *)elk_getFileHost
{
    return [ELKNetworkManager defaultManager].fileHost ?: @"";
}
/// 自己服务器上传图片
+ (void)elk_uploadImage:(id)image params:(NSDictionary *)params success:(ELKNetRespOxygen)success failure:(ELKNetRespFailure)failure
{
    NSString *fileHost = stdString([ELKNetworkManager elk_getFileHost]);
    if (fileHost.length == 0) {
        success(@"文件服务器地址为空", NO);
        return;
    }
    [ELKNetworkManager elk_uploadImageUrl:fileHost image:image params:params success:success failure:failure];
}

#pragma mark - 阿里OSSUpload图片上传
/// 使用阿里OSSUpload前，请先设置OSS信息
/// @param aliOSSInfo  阿里OSS Upload基础信息
+ (void)elk_setAliOSSInfo:(ELKAliOSSInfoModel *)aliOSSInfo
{
    [ELKNetworkManager defaultManager].aliOSSInfo = aliOSSInfo;
}
/// 阿里OSS上传图片
+ (void)elk_ossUpload:(ELKUploadFileInfoModel *)fileData progress:(ELKNetRespProgress)progress success:(ELKNetRespOxygen)success failure:(ELKNetRespFailure)failure
{
    ELKAliOSSInfoModel *aliOSSInfo = [ELKNetworkManager defaultManager].aliOSSInfo;
    [ELKNetworkManager elk_aliOSSUpload:aliOSSInfo file:fileData progress:progress success:success failure:failure];
}


#pragma mark - 网络相关
+ (NSMutableURLRequest *_Nonnull)requestUrl:(NSString *)reqUrl method:(ELK_NetReqMethod)reqMethod
{
    NSString *reqMethodString = @"POST";
    if (reqMethod == ELK_ReqPost) {
        reqMethodString = @"POST";
    } else if (reqMethod == ELK_ReqGet) {
        reqMethodString = @"GET";
    }
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:reqMethodString URLString:reqUrl parameters:nil error:nil];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSString *CookieStr = [ELKNetworkManager elk_getCookie];
    [request setValue:CookieStr forHTTPHeaderField:@"Set-Cookie"];
    [request willChangeValueForKey:@"timeoutInterval"];
    request.timeoutInterval = 10;
    [request didChangeValueForKey:@"timeoutInterval"];
    
    return request;
}


#pragma mark -- 请求加解密
/// 请求参数格式化+加密
/// @param params 参数字典
/// @param encry  是否加密
+ (NSData *)elk_paramsFormat:(NSDictionary *)params encry:(BOOL)encry
{
    NSString *jsonParams =  [self returnJson:params];
    if ([ELKNetworkManager elk_cryptStatus]) {
        if (encry) {
            NSString *aesKey = [ELKNetworkManager elk_getUserToken];
            NSString *encryParamString = [Encryption jun_encryptionWithAes256AndBase64EncrypString:jsonParams aesKey:aesKey];
            NSData *paramsData = [encryParamString dataUsingEncoding:NSUTF8StringEncoding];
            
            return paramsData;
        } else {
            NSData *paramsData = [jsonParams dataUsingEncoding:NSUTF8StringEncoding];
            
            return paramsData;
        }
    } else {
        NSData *paramsData = [jsonParams dataUsingEncoding:NSUTF8StringEncoding];
        
        return paramsData;
    }
}

/// 返回数据解析+解密
/// @param respObject 返回数据信息
+ (NSDictionary *)elk_respDataSerializa:(id _Nullable)respObject
{
    NSError *jsonError = nil;
    NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:respObject options:NSJSONReadingMutableContainers error:&jsonError];
    if (!resDict || jsonError) {
        return @{@"code":@0,
                 @"errMsg":@"解析出错"};
    }
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithDictionary:resDict];
    id dataDict = resDict[@"data"];
    if ([dataDict isKindOfClass:[NSString class]]) {
        NSString *aesKey = [ELKNetworkManager elk_getUserToken];
        NSString *json = [Encryption jun_encryptionWithAes256AndBase64DecryptString:dataDict aesKey:aesKey];
        json = [json stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
        if (json) {
            NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            if (jsonDict) {
                [resultDict setObject:jsonDict forKey:@"data"];
            }
        }
    }
    
    return resultDict;
}

// 生成json格式的文本
+ (NSString *)returnJson:(id)params
{
    if (!params) {
        return @"";
    }
    NSString *jsonString = @"";
    NSError *jsonError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&jsonError];
    if (jsonData && !jsonError) {
        jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    return jsonString;
}


#pragma mark - 域名 加密开关
/// 设置加密开关|参数加密状态
+ (void)elk_setCryptStatus:(ELK_NetAESCryptType)cryptType
{
     [ELKNetworkManager defaultManager].cryptType = cryptType;
}
/// 当前是否开启加解密 YES OR NO
+ (BOOL)elk_cryptStatus
{
    if ([ELKNetworkManager defaultManager].cryptType == ELK_AESTypeEnable) {
        return YES;
    }
    return NO;
}
/// 设置加密密匙
/// @param userToken 密匙
+ (void)elk_setUserToken:(NSString *)userToken
{
    NSString *uToken = userToken ?: @"";
    [ELKNetworkManager defaultManager].userToken = uToken;
}
/// 获取加密匙
+ (NSString *)elk_getUserToken
{
    NSString *keyString = @"";
    if ([ELKNetworkManager defaultManager].userToken && [ELKNetworkManager defaultManager].userToken.length > 0) {
        keyString = [NSString stringWithFormat:@"%@", [ELKNetworkManager defaultManager].userToken];
    }
    return keyString;
}

/// 取SESSION
+ (NSString *)elk_getCookie
{
    NSString *cookieStr = stdString([ELKNetworkManager defaultManager].userCookie);
    return cookieStr;
}


/// 清除登录的信息
+ (void)elk_clearLoginInfo
{
    [ELKNetworkManager elk_setUserToken:@""];
    [ELKNetworkManager elk_setCryptStatus:ELK_AESTypeEnable];
}



@end
