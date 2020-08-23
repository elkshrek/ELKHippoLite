//
//  ELKEasyTimer.m
//  ELKHippoLite
//
//  Created by wing on 2020/2/4.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKEasyTimer.h"

@interface ELKEasyTimer ()

@property (nonatomic, strong) NSTimer *elkTimer;
@property (nonatomic, assign) NSInteger repeatCount;

@property (nonatomic, weak) id<ELKEasyTimerDelegate> delegate;

@property (nonatomic, copy) ELKEasyTimerBlock elk_easyTimerBlock;

@end

@implementation ELKEasyTimer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.elkTimer = nil;
        self.repeatCount = 0;
    }
    return self;
}

/// 开启一个定时器
/// @param ti       定时间隔时间
/// @param rpCount  重复次数：0表示无限次
/// @param easyBock 步进时间
+ (ELKEasyTimer *)elk_easyTimeInterval:(NSTimeInterval)ti repeat:(NSInteger)rpCount block:(ELKEasyTimerBlock)easyBock
{
    ELKEasyTimer *easyTimer = [[ELKEasyTimer alloc] init];
    easyTimer.repeatCount = rpCount > 0 ? rpCount : MAXFLOAT;
    easyTimer.elkTimer = [NSTimer scheduledTimerWithTimeInterval:ti target:easyTimer selector:@selector(elk_easyTimerEvent:) userInfo:nil repeats:YES];
    easyTimer.elk_easyTimerBlock = easyBock;
    
    return easyTimer;
}

/// 开启一个定时器并设置步进事件代理
/// @param ti       定时间隔时间
/// @param rpCount  重复次数：0表示无限次
/// @param delegate 步进事件代理
+ (ELKEasyTimer *)elk_easyTimeInterval:(NSTimeInterval)ti repeat:(NSInteger)rpCount delegate:(id<ELKEasyTimerDelegate>)delegate
{
    ELKEasyTimer *easyTimer = [[ELKEasyTimer alloc] init];
    easyTimer.repeatCount = rpCount > 0 ? rpCount : MAXFLOAT;
    easyTimer.elkTimer = [NSTimer scheduledTimerWithTimeInterval:ti target:easyTimer selector:@selector(elk_easyTimerEvent:) userInfo:nil repeats:YES];
    easyTimer.delegate = delegate;
    
    return easyTimer;
}

- (void)elk_easyTimerEvent:(NSTimer *)timer
{
    self.repeatCount--;
    if (self.elk_easyTimerBlock) {
        self.elk_easyTimerBlock(self, self.repeatCount);
    }
    if ([self.delegate respondsToSelector:@selector(elk_easyTimerEvent:step:)]) {
        [self.delegate elk_easyTimerEvent:self step:self.repeatCount];
    }
    if (self.repeatCount <= 0) {
        [self elk_invalidate];
    }
}

- (void)elk_invalidate
{
    [self.elkTimer invalidate];
    self.elkTimer = nil;
    self.elk_easyTimerBlock = nil;
}

- (void)dealloc
{
    [self.elkTimer invalidate];
    self.elkTimer = nil;
    self.elk_easyTimerBlock = nil;
}


@end
