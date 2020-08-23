//
//  ELKCommonLiteHeader.h
//  ELKHippoLite
//
//  Created by wing on 2020/5/6.
//  Copyright © 2020 wing. All rights reserved.
//

#ifndef ELKCommonLiteHeader_h
#define ELKCommonLiteHeader_h


#pragma mark - 屏幕尺寸定义
#ifndef ELKScreenWidth
/// 主屏幕宽度
#define ELKScreenWidth        ([[UIScreen mainScreen] bounds].size.width)
/// 主屏幕高度
#define ELKScreenHeight       ([[UIScreen mainScreen] bounds].size.height)

/// 主屏幕状态栏高度
#define ELK_StatusBarHeight   ([UIApplication sharedApplication].statusBarFrame.size.height)

/// 是否刘海屏幕
#define ELK_isiPhoneX         ((ELK_StatusBarHeight > 21.f) ? YES : NO)
/// 导航栏高度
#define ELK_NavBarHeight      (ELK_isiPhoneX ? 88.f : 64.f)
/// 顶部安全高度
#define ELK_SafeTop           (ELK_isiPhoneX ? 44.f : 0.f)
/// tabbar高度
#define ELK_TabBarHeight      (ELK_isiPhoneX ? 83.f : 49.f)
/// 底部安全高度
#define ELK_SafeBottom        (ELK_isiPhoneX ? 34.f : 0.f)

#define ELKScreenScale        [UIScreen mainScreen].scale

/// 屏幕宽度和375的比值
#define ELKWidthRatio375      (ELKScreenWidth / 375.0)
/// 宽和375屏的对比适应
#define ELKAdaptWidth(wd)     (wd * ELKWidthRatio375)

/// 获取View的属性
#define ELKGetViewWidth(view)  view.frame.size.width
#define ELKGetViewHeight(view) view.frame.size.height
#define ELKGetViewX(view)      view.frame.origin.x
#define ELKGetViewY(view)      view.frame.origin.y

#endif


#pragma mark - 系统等级
#ifndef ELKDevSysVersion

#define ELKDevSysVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

#endif

#ifndef ELK_iOS9
/// iOS 9.0系统及更高
#define ELK_iOS9  (ELKDevSysVersion >= 9.0)
#endif

#ifndef ELK_iOS10
/// iOS 10.0系统及更高
#define ELK_iOS10 (ELKDevSysVersion >= 10.0)
#endif

#ifndef ELK_iOS11
/// iOS 11.0系统及更高
#define ELK_iOS11 (ELKDevSysVersion >= 11.0)
#endif

#ifndef ELK_iOS12
/// iOS 12.0系统及更高
#define ELK_iOS12 (ELKDevSysVersion >= 12.0)
#endif

#ifndef ELK_iOS13
/// iOS 13.0系统及更高
#define ELK_iOS13 (ELKDevSysVersion >= 13.0)
#endif

#ifndef ELK_iOS14
/// iOS 14.0系统及更高
#define ELK_iOS14 (ELKDevSysVersion >= 14.0)
#endif


#pragma mark - App版本号及信息
#ifndef ELKAppVersion
/// 应用版本号字符串
#define ELKAppVersion  [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]
#endif

#ifndef ELKAppBuild
/// 应用Build号
#define ELKAppBuild  [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]
#endif

#ifndef ELKAppName
/// 应用名称
#define ELKAppName  [NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]]
#endif

#ifndef ELKAppIconImage
/// 应用icon图片
#define ELKAppIconImage [UIImage imageNamed:[[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]]
#endif

#ifndef ELKAppKeyWindow
/// 应用KeyWindow
#define ELKAppKeyWindow [UIApplication sharedApplication].keyWindow
#endif

#ifndef ELKAppDelegate
/// 应用的AppDelegate
#define ELKAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#endif



#pragma mark - 避免循环引用
/// 避免循环引用
#ifndef e_weakify
    #define e_weakify(var) __weak typeof(var) ELKWeak_##var = var;
#endif

#ifndef e_strongify
#define e_strongify(var) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    __strong typeof(var) var = ELKWeak_##var; \
    _Pragma("clang diagnostic pop")
#endif


#pragma mark - 数据检验及简单容错
/// NSNumber类型
#ifndef stdNumber
    #define chkNumber(oNbr)  ([oNbr isKindOfClass:[NSNumber class]])
    #define stdNumber(oNbr)  (chkNumber(oNbr) ? oNbr : @0)
#endif
/// NSString类型
#ifndef stdString
    #define chkString(oStr)  ([oStr isKindOfClass:[NSString class]])
    #define stdString(oStr)  (chkString(oStr) ? oStr : @"")
#endif


#pragma mark - 应用商店链接
#ifndef ELKAppStoreUrl
    #define ELKAppStoreUrl(apsId)  [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",apsId]
#endif


#ifndef ELKAlphaNum
#define ELKAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#endif


#pragma mark - 自定义NSlog
//#ifdef DEBUG
//#define NSLog(format, ...) do {                 \
//        fprintf(stderr, "<%s : %d> %s : ",      \
//        [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
//        __LINE__, __func__);                    \
//        (NSLog)((format), ##__VA_ARGS__);       \
//        fprintf(stderr, "\n");                  \
//    } while(0)
//#endif

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#endif








#endif /* ELKCommonLiteHeader_h */
