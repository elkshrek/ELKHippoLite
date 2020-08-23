//
//  ELKAccountTool.m
//  StarDreamiOS
//
//  Created by wing on 2019/8/13.
//  Copyright © 2019 elk. All rights reserved.
//

#import "ELKAccountTool.h"
#import "ELKMacroLite.h"

#define ELKAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ELKAccountInfoFile.data"]


@implementation ELKAccountTool


// 存储|更新账号信息
+ (void)saveAccount:(ELKAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:ELKAccountFile];
}


// 获取账号信息
+ (__kindof ELKAccount *_Nullable)account
{
    @try {
        ELKAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ELKAccountFile];
        
        return account;
    } @catch (NSException *exception) {
        NSLog(@"获取账号信息异常");
        
        return nil;
    } @finally {
        
    }
}

/**
 检测账号状态是否可用
 
 @return 账号合法 YES 不合法 NO
 */
+ (BOOL)checkAccount
{
    ELKAccount *account = [ELKAccountTool account];
    BOOL isLegal = NO;
    if (account) {
        if ([stdNumber(account.userId) integerValue] && stdString(account.token).length) {
            isLegal = YES;
        }
    }
    
    return isLegal;
}


/// 检测用户不是是自己
/// @param cusId 用户id
/// return  true ：不是自己  failed：是自己
+ (BOOL)checkUserIdNotMine:(NSNumber *)cusId
{
    ELKAccount *account = [ELKAccountTool account];
    BOOL notMine = YES;
    if (account) {
        if ([stdNumber(cusId) integerValue] && [stdNumber(account.userId) integerValue] && [stdNumber(cusId) isEqualToNumber:stdNumber(account.userId)]) {
            notMine = NO;
        }
    }
    return notMine;
}

// 清除账号信息
+ (void)cleanAccount
{
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    [fileManager removeItemAtPath:ELKAccountFile error:nil];
    NSLog(@"清除账号信息...");
}



@end

