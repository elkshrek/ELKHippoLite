//
//  Encryption.m
//  Encryption
//
//  Created by 谭俊 on 2016/11/7.
//  Copyright © 2016年 中科院. All rights reserved.
//

#import "Encryption.h"
#import "NSString+MD5.h"
#import "NSString+SHA1.h"
#import <GTMBase64/GTMBase64.h>
#import "NSData+AES256.h"

#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000

@implementation Encryption

+ (NSString *)jun_encryptionWithMd5EncryptString:(NSString *)string {
    return [string jun_initWithMd5Encrypt];
}
+ (NSString *)jun_encryptionWithMd5EncryptData:(NSData *)data {
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [string jun_initWithMd5Encrypt];
}
+ (NSString *)jun_encryptionWithSha1EncryptString:(NSString *)string {
    return [string jun_initWithSha1Encrypt];
}
+ (NSString *)jun_encryptionWithSha1EncryptData:(NSData *)data {
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return [string jun_initWithSha1Encrypt];
}
+ (NSString *)jun_encryptionWithBase64EncodeString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self jun_encryptionWithBase64EncodeData:data];
}
+ (NSString *)jun_encryptionWithBase64DecodeString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self jun_encryptionWithBase64DecodeData:data];
}
+ (NSString *)jun_encryptionWithBase64EncodeData:(NSData *)data {
    data = [GTMBase64 encodeData:data];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
+ (NSString *)jun_encryptionWithBase64DecodeData:(NSData *)data {
    data = [GTMBase64 decodeData:data];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
+ (NSString *)jun_encryptionWithAes256EncryptString:(NSString *)string aesKey:(NSString *)key {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self jun_encryptionWithAes256EncryptData:data aesKey:key];
}
+ (NSString *)jun_encryptionWithAes256DecryptString:(NSString *)string aesKey:(NSString *)key {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self jun_encryptionWithAes256DecryptData:data aesKey:key];
}
+ (NSString *)jun_encryptionWithAes256EncryptData:(NSData *)data aesKey:(NSString *)key {
    data = [data jun_initWithAes256EncryptKey:key];
    data = [GTMBase64 encodeData:data];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
+ (NSString *)jun_encryptionWithAes256DecryptData:(NSData *)data aesKey:(NSString *)key {
    data = [GTMBase64 decodeData:data];
    data = [data jun_initWithAes256DecryptKey:key];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/// 对string 进行 AES256 + Base64 加密
+ (NSString *)jun_encryptionWithAes256AndBase64EncrypString:(NSString *)string aesKey:(NSString *)key
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64 = @"";
    NSData *newData = [[NSData alloc] init];;
    if (data.length > 128) {
        for (int i = 0; i < ceil(data.length / 128); i++) {
            if (i == ceil(data.length / 128) - 1) {
                newData = [data subdataWithRange:NSMakeRange(i * 128, data.length - i * 128)];
            } else {
                newData = [data subdataWithRange:NSMakeRange(i * 128, 128)];
            }
            base64 = [base64 stringByAppendingString:[NSString stringWithFormat:@"%@_", [self jun_encryptionWithAes256AndBase64EncrypData:newData aesKey:key]]];
        }
        base64 = [base64 substringToIndex:base64.length - 1];
    } else {
        base64 = [self jun_encryptionWithAes256AndBase64EncrypData:data aesKey:key];
    }
    return base64;
}

/// 对string 进行 AES256 + Base64 解密
+ (NSString *)jun_encryptionWithAes256AndBase64DecryptString:(NSString *)string aesKey:(NSString *)key {
    NSArray *array = [string componentsSeparatedByString:@"_"];
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:array];
    [arrayM removeLastObject];
    array = nil;
    array = arrayM.copy;
    NSMutableData *dataM = [NSMutableData data];
    if (!array.count) {
        NSData *data = [GTMBase64 decodeString:string];
         return [[NSString alloc] initWithData:[self jun_encryptionWithAes256AndBase64DecryptData:data aesKey:key] encoding:NSUTF8StringEncoding];
    }
    for (NSString *str in array) {
        NSData *data = [GTMBase64 decodeString:str];
        [dataM appendData:[self jun_encryptionWithAes256AndBase64DecryptData:data aesKey:key]];
    }
    return [[NSString alloc] initWithData:dataM.copy encoding:NSUTF8StringEncoding];
}
/// 对data 进行 AES256 + Base64 加密
+ (NSString *)jun_encryptionWithAes256AndBase64EncrypData:(NSData *)data aesKey:(NSString *)key {
    data = [data jun_initWithAes256EncryptKey:key];
    return [GTMBase64 stringByEncodingData:data];
}
/// 对data 进行 AES256 + Base64 解密
+ (NSData *)jun_encryptionWithAes256AndBase64DecryptData:(NSData *)data aesKey:(NSString *)key {
    data = [data jun_initWithAes256DecryptKey:key];
//    data = [data UTF8Data:data];
    return data;
    //[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
