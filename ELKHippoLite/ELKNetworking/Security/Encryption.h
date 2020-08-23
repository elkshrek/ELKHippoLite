//
//  Encryption.h
//  Encryption
//
//  Created by 谭俊 on 2016/11/7.
//  Copyright © 2016年 中科院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject

/// 对 string 进行 MD5 编码
+ (NSString *)jun_encryptionWithMd5EncryptString:(NSString *)string;
/// 对 data 进行 MD5 编码
+ (NSString *)jun_encryptionWithMd5EncryptData:(NSData *)data;
/// 对 string 进行 SHA1 编码
+ (NSString *)jun_encryptionWithSha1EncryptString:(NSString *)string;
/// 对 data 进行 SHA1 编码
+ (NSString *)jun_encryptionWithSha1EncryptData:(NSData *)data;
/// 对 string 进行 Base64 加密
+ (NSString *)jun_encryptionWithBase64EncodeString:(NSString *)string;
/// 对 string 进行 Base64 解密
+ (NSString *)jun_encryptionWithBase64DecodeString:(NSString *)string;
/// 对 data 进行 Base64 加密
+ (NSString *)jun_encryptionWithBase64EncodeData:(NSData *)data;
/// 对 data 进行 Base64 解密
+ (NSString *)jun_encryptionWithBase64DecodeData:(NSData *)data;
/// 对 string 进行 Base64 + AES256 加密
+ (NSString *)jun_encryptionWithAes256EncryptString:(NSString *)string aesKey:(NSString *)key;
/// 对 string 进行 Base64 + AES256 解密
+ (NSString *)jun_encryptionWithAes256DecryptString:(NSString *)string aesKey:(NSString *)key;
/// 对 data 进行 Base64 + AES256 加密
+ (NSString *)jun_encryptionWithAes256EncryptData:(NSData *)data aesKey:(NSString *)key;
/// 对 data 进行 Base64 + AES256 解密
+ (NSString *)jun_encryptionWithAes256DecryptData:(NSData *)data aesKey:(NSString *)key;


/// 对string 进行 AES256 + Base64 加密
+ (NSString *)jun_encryptionWithAes256AndBase64EncrypString:(NSString *)string aesKey:(NSString *)key;
/// 对string 进行 AES256 + Base64 解密
+ (NSString *)jun_encryptionWithAes256AndBase64DecryptString:(NSString *)string aesKey:(NSString *)key;
/// 对data 进行 AES256 + Base64 加密
+ (NSString *)jun_encryptionWithAes256AndBase64EncrypData:(NSData *)data aesKey:(NSString *)key;
/// 对data 进行 AES256 + Base64 解密
+ (NSData *)jun_encryptionWithAes256AndBase64DecryptData:(NSData *)data aesKey:(NSString *)key;

@end
