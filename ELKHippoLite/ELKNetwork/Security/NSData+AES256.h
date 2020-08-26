//
//  NSData+AES256.h
//  Encryption
//
//  Created by 谭俊 on 2016/11/7.
//  Copyright © 2016年 中科院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

- (NSData *)jun_initWithAes256EncryptKey:(NSString *)key;
- (NSData *)jun_initWithAes256DecryptKey:(NSString *)key;

@end
