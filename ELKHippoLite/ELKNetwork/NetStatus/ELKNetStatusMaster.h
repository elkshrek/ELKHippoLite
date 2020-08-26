//
//  ELKNetStatusMaster.h
//  ELKHippoLite
//
//  Created by wing on 2020/3/18.
//  Copyright © 2020 wing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 网络状态发生变化通知
/// 接收userinfo 格式
/// @{@"status":@(ELK_NetWWAN),
///   @"description":@"移动网络"}
#ifndef ELK_kNotificationNetWorkChange
    #define ELK_kNotificationNetWorkChange @"ELK_kNotificationNetWorkChange"
#endif

/// 网络状态
typedef NS_OPTIONS(NSUInteger, ELK_NetStatus) {
    /// 未知
    ELK_NetUnknown = 1 << 0,
    /// 没网
    ELK_NetNone    = 1 << 1,
    /// 移动网
    ELK_NetWWAN    = 1 << 2,
    /// WiFi
    ELK_NetWiFi    = 1 << 3,
};

typedef void(^ELKNetStatusBlock)(ELK_NetStatus netStatus);

@interface ELKNetStatusMaster : NSObject

#pragma mark - 网络监控
/// 开启网络监测
+ (void)elk_networkMonitoring;
/// 开启网络监测 并获取变化情况
/// @param netBlock 网络状态反馈
+ (void)elk_networkMonitorBlock:(ELKNetStatusBlock)netBlock;
/// 获取网络状态  必须先开启网络监测
+ (ELK_NetStatus)elk_netStatus;


@end

NS_ASSUME_NONNULL_END
