//
//  NSData+AES256.m
//  Encryption
//
//  Created by 谭俊 on 2016/11/7.
//  Copyright © 2016年 中科院. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>

#import "NSData+AES256.h"

@implementation NSData (AES256)

- (NSData *)jun_initWithAes256EncryptKey:(NSString *)key {
    char keyPtr[kCCKeySizeAES128 + 1];      // 定义数组长度，在 C 语言中，Ptr 为 Pointer 的缩写
    bzero(keyPtr, sizeof(keyPtr));          // bzero 函数说明：将内存前 n 个字节清零，keyPte 为要置零的数据的起始地址，sizeof(keyPtr) 为要置零的数据字节个数
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)jun_initWithAes256DecryptKey:(NSString *)key {
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

@end
