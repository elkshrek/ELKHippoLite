//
//  ELKNetworkManager+Upload.m
//  ELKHippoLite
//
//  Created by Jonathan on 2019/4/18.
//  Copyright © 2019 elk. All rights reserved.
//

#import "ELKNetworkManager+Upload.h"
#import "ELKMacroLite.h"
#import <AliyunOSSiOS/AliyunOSSiOS.h>
#import <AVKit/AVKit.h>

@implementation ELKNetworkManager (Upload)


#pragma mark - 上传文件  表单上传
static NSString *elk_separateStr = @"--";
static NSString *elk_boundaryStr = @"ELKNetworkManagerUpload";
static NSString *elk_uploadID    = @"uploadFile";




/// 上传图片
/// @param urlString 完整文件服务器地址
/// @param image     图片信息 [UIImage | NSData]
/// @param params    附加参数
/// @param success   成功反馈
/// @param failure   失败反馈
+ (void)elk_uploadImageUrl:(NSString *)urlString image:(id)image params:(NSDictionary *)params success:(ELKNetRespOxygen)success failure:(ELKNetRespFailure)failure
{
    if (stdString(urlString).length == 0) {
        success(@"文件服务器地址为空", NO);
        return;
    }
    // 上传的数据
    NSData *uploadData;
    if ([image isKindOfClass:[UIImage class]]) {
        uploadData = UIImageJPEGRepresentation(image, 0.5f);
    } else if ([image isKindOfClass:[NSData class]]) {
        uploadData = image;
    }
    NSMutableData *dataBody = [NSMutableData data];
    [dataBody appendData:[self parameterWithDict:params]];
    if ([uploadData length] != 0) {
        [dataBody appendData:[self fileData:uploadData mimeType:@"image/jpeg/jpg/png" uploadFile:[self randomImageFileName]]];
    }
    [dataBody appendData:[self suffixOfUpload]];
    
    NSMutableURLRequest *request = [self uploadReqWithUrl:urlString andData:dataBody];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            BOOL uploadStatus = YES;
            if ([resDict isKindOfClass:[NSDictionary class]] && [resDict[@"status"] isKindOfClass:[NSNumber class]]) {
                NSInteger status = [resDict[@"status"] integerValue];
                if (status == 0) {
                    uploadStatus = NO;
                }
            }
            NSString *resString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            resString = [resString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            if (success) {
                success(resString, uploadStatus);
            }
        } else {
            if (failure) {
                failure(error);
            }
        }
    }] resume];
    
}


/// 阿里OSS文件上传: UIImage(图片) | AVAsset(视频) | NSData(图片的Data数据)
+ (void)elk_aliOSSUpload:(ELKAliOSSInfoModel *)aliOSSInfo file:(ELKUploadFileInfoModel *_Nonnull)fileData progress:(ELKNetRespProgress)progress success:(ELKNetRespOxygen)success failure:(ELKNetRespFailure)failure
{
    NSString *accKey = stdString(aliOSSInfo.accessKey);
    NSString *secretKey = stdString(aliOSSInfo.secretKey);
    if (accKey.length == 0 || secretKey.length == 0) {
        success(@"阿里AccessKey和SecretKey不能为空", NO);
        return;
    }
    // endpoint default : https://oss-cn-beijing.aliyuncs.com
    NSString *endPoint = stdString(aliOSSInfo.endPoint);
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:accKey secretKeyId:secretKey securityToken:@""];
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    // bucketName default : efei
    NSString *bucketName = stdString(aliOSSInfo.bucketName);
    put.bucketName = bucketName;
    // picturePath default : picture/
    NSString *picturePath = stdString(fileData.filePath);
    picturePath = [picturePath hasSuffix:@"/"] ? picturePath : [NSString stringWithFormat:@"%@/", picturePath];
    // 上传的数据
    NSString *filePathUrl = @"";
    if ([fileData.fileData isKindOfClass:[AVAsset class]]) {
        AVURLAsset *asset = (AVURLAsset *)fileData.fileData;
        put.uploadingFileURL = asset.URL;
        NSString *videoName = [NSString stringWithFormat:@"%@.MOV", [self randomFileName]];
        filePathUrl = [NSString stringWithFormat:@"%@%@", picturePath, videoName];
    } else {
        NSData *uploadData = fileData.fileData;
        if ([fileData.fileData isKindOfClass:[UIImage class]]) {
            UIImage *img = (UIImage *)fileData.fileData;
            uploadData = UIImageJPEGRepresentation(img, 0.5f);
        }
        put.uploadingData = uploadData;
        NSString *picName = [self randomImageFileName];
        filePathUrl = [NSString stringWithFormat:@"%@%@", picturePath, picName];
    }
    put.objectKey = filePathUrl;
    
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
        CGFloat current = 1.f * totalBytesSent / totalBytesExpectedToSend;
        if (progress) {
            progress(current);
        }
    };
    OSSTask *putTask = [client putObject:put];
    [putTask continueWithBlock:^id _Nullable(OSSTask * _Nonnull task) {
        task = [client presignPublicURLWithBucketName:bucketName withObjectKey:filePathUrl];
        NSLog(@"-------- %@   %@", task.result, filePathUrl);
        if (!task.error) {
            //上传成功
            if (success) {
                success(task.result, YES);
            }
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
            if (failure) {
                failure(task.error);
            }
        }
        return nil;
    }];
}




/**
 创建数据上传的URLRequest
 
 @param bodyData 文件数据
 @return NSURLRequest
 */
+ (NSMutableURLRequest *_Nonnull)uploadReqWithUrl:(NSString *)urlString andData:(NSData *_Nonnull)bodyData
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:0 timeoutInterval:60.0f];
    [request setHTTPMethod:@"POST"];
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", elk_boundaryStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    NSString *CookieStr = [ELKNetworkManager elk_getCookie];
    [request setValue:CookieStr forHTTPHeaderField:@"Set-Cookie"];
    NSUInteger len = bodyData.length;
    NSString *strLen = [NSString stringWithFormat:@"%lu",(unsigned long)len];
    [request addValue:strLen forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:bodyData];
    
    return request;
}


/**
 文件参数
 
 @param file 文件数据 data
 @param mimeType mimeType
 @param fileName 文件名
 @return 数据
 */
+ (NSData *_Nonnull)fileData:(NSData *_Nonnull)file mimeType:(NSString *_Nonnull)mimeType uploadFile:(NSString *_Nonnull)fileName
{
    NSMutableData *body = [NSMutableData data];
    [body appendData:[self dataEncode:[NSString stringWithFormat:@"%@%@\r\n", elk_separateStr, elk_boundaryStr]]];
    [body appendData:[self dataEncode:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", elk_uploadID, fileName]]];
    [body appendData:[self dataEncode:[NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType]]];
    
    [body appendData:[self dataEncode:@"\r\n"]];
    [body appendData:file];// 文件
    [body appendData:[self dataEncode:@"\r\n"]];
    
    return body;
}

/**
 非文件参数
 
 @param parameter 参数列表 [字典]
 @return 参数数据
 */
+ (NSData *)parameterWithDict:(NSDictionary *_Nullable)parameter
{
    if ([parameter isKindOfClass:[NSDictionary class]]) {
        NSArray *keysArr = [parameter allKeys];
        NSMutableString *strM = [NSMutableString string];
        
        for (NSString *keyStr in keysArr) {
            [strM appendFormat:@"%@%@\r\n", elk_separateStr, elk_boundaryStr];
            [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", keyStr];
            [strM appendString:@"\r\n"];
            [strM appendFormat:@"%@", parameter[keyStr]];
            [strM appendString:@"\r\n"];
        }
        return [self dataEncode:strM];
    }
    return [NSData data];
}


/// 结尾标识
+ (NSData *)suffixOfUpload
{
    return [self dataEncode:[NSString stringWithFormat:@"%@%@%@\r\n", elk_separateStr, elk_boundaryStr, elk_separateStr]];
}

+ (NSData *)dataEncode:(NSString *)str
{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

/// 获取随机生成图片名
+ (NSString *)randomImageFileName
{
    NSString *fileName = [NSString stringWithFormat:@"%@.png", [self randomFileName]];
    NSLog(@"random image fileName %@", fileName);
    
    return fileName;
}

+ (NSString *)randomFileName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%d%@", (arc4random() % 100000) + 1, str];
    return fileName;
}


@end
