//
//  NSString+ELKAdditions.h
//  ELKParallel
//
//  Created by wing on 2019/12/30.
//  Copyright © 2019 wing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ELKAdditions)

/// 应用名称
+ (NSString *)elk_getAppName;
/// App版本号
+ (NSString *)elk_getAppVersion;


/// 校验身份证号码是否正确 返回BOOL值
- (BOOL)elk_verifyIDCardString;

/// 校验大陆手机号
- (BOOL)elk_isValidMobile;
/// 校验是否合格的数字验证码 4位 | 6位
- (BOOL)elk_isValidVerifyCode;
/// 校验符合6~12位数字加字母密码
- (BOOL)elk_isValidAlphaNumPassword;
/// 校验银行卡位数
- (BOOL)elk_isValidBankCardNum;
/// 校验是否纯中文
- (BOOL)elk_isOnlyChinese;

/// 正则校验信息，使用传入的谓语
/// @param pattern 谓语字符串
- (BOOL)elk_checkValidWithPred:(NSString *)pattern;


/// 手机号中间4位替换为****号
- (NSString *)elk_transformSecretMobile;

/// 设备号UUID
+ (NSString*)UUID;


@end

NS_ASSUME_NONNULL_END
