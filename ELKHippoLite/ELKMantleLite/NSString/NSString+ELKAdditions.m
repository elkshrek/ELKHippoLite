//
//  NSString+ELKAdditions.m
//  ELKParallel
//
//  Created by wing on 2019/12/30.
//  Copyright © 2019 wing. All rights reserved.
//

#import "NSString+ELKAdditions.h"

@implementation NSString (ELKAdditions)


/// 应用名称
+ (NSString *)elk_getAppName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"] ?: @"";
    
    return appName;
}
/// App版本号
+ (NSString *)elk_getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"] ?: @"";
    
    return appVersion;
}


/// 校验大陆手机号
- (BOOL)elk_isValidMobile
{
    NSString *mobile = @"^1(3|4|5|6|7|8|9)\\d{9}$";
    return [self elk_checkValidWithPred:mobile];
}
/// 校验是否合格的数字验证码 4位 | 6位
- (BOOL)elk_isValidVerifyCode
{
    NSString *pattern = @"^(\\d{4}|\\d{6})$";
    return [self elk_checkValidWithPred:pattern];
}
/// 校验符合6~12位数字加字母密码
- (BOOL)elk_isValidAlphaNumPassword
{
    NSString *alphaPwd = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$";
    return [self elk_checkValidWithPred:alphaPwd];
}
/// 校验银行卡位数
- (BOOL)elk_isValidBankCardNum
{
    NSString *bankCard = @"^(\\d{16}|\\d{19})$";
    return [self elk_checkValidWithPred:bankCard];
}
/// 校验是否纯中文
- (BOOL)elk_isOnlyChinese
{
    NSString *chinese = @"^[\u4e00-\u9fa5]{0,}$";
    return [self elk_checkValidWithPred:chinese];
}

/// 正则校验信息，使用传入的谓语
/// @param pattern 谓语字符串
- (BOOL)elk_checkValidWithPred:(NSString *)pattern
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:self];
}



/// 手机号中间4位替换为****号
- (NSString *)elk_transformSecretMobile
{
    if ([self elk_isValidMobile]) {
        NSRange mobRange = NSMakeRange(3, 4);
        NSString *secret = [self stringByReplacingCharactersInRange:mobRange withString:@"****"];
        return secret;
    }
    return self;
}


/**
 校验身份证号码是否正确 返回BOOL值

 @return 返回BOOL值 YES or NO
 */
- (BOOL)elk_verifyIDCardString
{
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:self];
    if (!isRe) {
         //身份证号码格式不对
        return NO;
    }
    //加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];

    NSInteger sum = 0;//保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) {//将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [self substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }

    NSInteger modNum = sum % 11;//总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; //根据余数取出校验码
    NSString *idCardLast = [self.uppercaseString substringFromIndex:17]; //获取身份证最后一位

    if (modNum == 2) {//等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { //身份证号码验证成功
        return YES;
    } else { //身份证号码验证失败
        return NO;
    }
}


/// 设备号UUID
+ (NSString*)UUID
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}




@end
