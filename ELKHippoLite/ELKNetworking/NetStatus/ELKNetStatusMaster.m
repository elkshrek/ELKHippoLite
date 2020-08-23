//
//  ELKNetStatusMaster.m
//  ELKHippoLite
//
//  Created by wing on 2020/3/18.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKNetStatusMaster.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@interface ELKNetStatusMaster ()

@property (nonatomic, assign) ELK_NetStatus netStatus;
@property (nonatomic, copy) ELKNetStatusBlock elkNetBlock;

@end

@implementation ELKNetStatusMaster

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.netStatus = ELK_NetUnknown;
    }
    return self;
}


+ (instancetype)defaultMaster
{
    static ELKNetStatusMaster *netMaster = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netMaster = [[ELKNetStatusMaster alloc] init];
    });
    return netMaster;
}

#pragma mark -- 网络监测
/// 开启网络监测
+ (void)elk_networkMonitoring
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                [ELKNetStatusMaster defaultMaster].netStatus = ELK_NetUnknown;
                NSLog(@"未知");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                [ELKNetStatusMaster defaultMaster].netStatus = ELK_NetNone;
                NSLog(@"此时没有网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [ELKNetStatusMaster defaultMaster].netStatus = ELK_NetWWAN;
                NSLog(@"移动网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [ELKNetStatusMaster defaultMaster].netStatus = ELK_NetWiFi;
                NSLog(@"WiFi");
            }
                break;
            default:
                break;
        }
        
    }];
    
}
/// 开启网络监测 并获取变化情况
/// @param netBlock 网络状态反馈
+ (void)elk_networkMonitorBlock:(ELKNetStatusBlock)netBlock
{
    [self elk_networkMonitoring];
    [ELKNetStatusMaster defaultMaster].elkNetBlock = netBlock;
    
}

- (void)setNetStatus:(ELK_NetStatus)netStatus
{
    _netStatus = netStatus;
    if (self.elkNetBlock) {
        self.elkNetBlock(netStatus);
    }
    NSMutableDictionary *userinfo = [[NSMutableDictionary alloc] init];
    [userinfo setValue:@(netStatus) forKey:@"status"];
    NSString *netDescription = @"未知";
    switch (netStatus) {
        case ELK_NetUnknown:
            netDescription = @"未知";
            break;
        case ELK_NetNone:
            netDescription = @"没有网络";
            break;
        case ELK_NetWiFi:
            netDescription = @"WiFi";
            break;
        case ELK_NetWWAN:
            netDescription = @"移动网络";
            break;
            
        default:
            netDescription = @"未知";
            break;
    }
    [userinfo setValue:netDescription forKey:@"description"];
    [[NSNotificationCenter defaultCenter] postNotificationName:ELK_kNotificationNetWorkChange object:nil userInfo:userinfo];
    
}
/// 获取网络状态
+ (ELK_NetStatus)elk_netStatus
{
    return [ELKNetStatusMaster defaultMaster].netStatus;
}


@end
