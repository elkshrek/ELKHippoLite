//
//  NSString+MD5.m
//  Encryption
//
//  Created by 谭俊 on 2016/11/7.
//  Copyright © 2016年 中科院. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>

#import "NSString+MD5.h"

@implementation NSString (MD5)

- (NSString *)jun_initWithMd5Encrypt {
    const char *cString = [self UTF8String];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, (CC_LONG)strlen(cString), digest);
    NSMutableString *mString = [NSMutableString string];
    for (NSInteger i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [mString appendFormat:@"%02x", digest[i]];
    }
    return mString.copy;
}

@end
