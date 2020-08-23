//
//  ELKEasyTimer.h
//  ELKHippoLite
//
//  Created by wing on 2020/2/4.
//  Copyright © 2020 wing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELKEasyTimer;
NS_ASSUME_NONNULL_BEGIN

/// 定时器步进事件block timer: 对象  stepCount: 距离结束的步数(结束定时器会自动释放，要提前释放，可以直接调用- (void)invalidate方法)
typedef void(^ELKEasyTimerBlock)(ELKEasyTimer *timer, NSInteger stepCount);

/// 定时器事件代理
@protocol ELKEasyTimerDelegate <NSObject>

@optional
/// 定时器步进事件反馈
/// @param timer     ELKEasyTimer 对象
/// @param stepCount 距离结束的步数(结束定时器会自动释放，要提前释放，可以直接调用- (void)invalidate方法)
- (void)elk_easyTimerEvent:(ELKEasyTimer *)timer step:(NSInteger)stepCount;

@end

@interface ELKEasyTimer : NSObject

/// 开启一个定时器
/// @param ti       定时间隔时间
/// @param rpCount  重复次数：0表示无限次
/// @param easyBock 步进事件
+ (ELKEasyTimer *)elk_easyTimeInterval:(NSTimeInterval)ti repeat:(NSInteger)rpCount block:(ELKEasyTimerBlock)easyBock;


/// 开启一个定时器并设置步进事件代理
/// @param ti       定时间隔时间
/// @param rpCount  重复次数：0表示无限次
/// @param delegate 步进事件代理
+ (ELKEasyTimer *)elk_easyTimeInterval:(NSTimeInterval)ti repeat:(NSInteger)rpCount delegate:(id<ELKEasyTimerDelegate>)delegate;


/// 手动停止
- (void)elk_invalidate;


@end

NS_ASSUME_NONNULL_END
