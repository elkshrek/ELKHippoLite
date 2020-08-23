//
//  NSString+SHA1.m
//  Encryption
//
//  Created by 谭俊 on 2016/11/7.
//  Copyright © 2016年 中科院. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>

#import "NSString+SHA1.h"

@implementation NSString (SHA1)

- (NSString *)jun_initWithSha1Encrypt {
    const char *cString = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cString length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (int)data.length, digest);
    NSMutableString *mString = [NSMutableString string];
    for (NSInteger i = 0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [mString appendFormat:@"%02x", digest[i]];
    }
    return mString.copy;
}

@end
