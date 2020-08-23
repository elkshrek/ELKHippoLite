//
//  ELKAccountTool.h
//  StarDreamiOS
//
//  Created by wing on 2019/8/13.
//  Copyright © 2019 elk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELKAccount.h"


NS_ASSUME_NONNULL_BEGIN

@interface ELKAccountTool : NSObject


/**
 *  存储|更新账号信息
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(ELKAccount *)account;


/**
 *  获取存储的账号信息
 */
+ (__kindof ELKAccount *_Nullable)account;


/**
 检测账号状态是否可用
 
 @return 账号合法 YES 不合法 NO
 */
+ (BOOL)checkAccount;


/**
 * 清除账号信息
 */
+ (void)cleanAccount;


/// 检测用户不是自己
/// @param cusId 用户id
/// return  true ：不是自己  failed：是自己
+ (BOOL)checkUserIdNotMine:(NSNumber *)cusId;



@end

NS_ASSUME_NONNULL_END
