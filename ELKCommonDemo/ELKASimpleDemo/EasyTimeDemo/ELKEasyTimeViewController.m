//
//  ELKEasyTimeViewController.m
//  ELKCommonDemo
//
//  Created by wing on 2020/6/4.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKEasyTimeViewController.h"
#import "ELKHippoLite.h"


@interface ELKEasyTimeViewController ()<ELKEasyTimerDelegate>

@property (nonatomic, strong) UIButton *timeBtn1;
@property (nonatomic, strong) UIButton *timeBtn2;

@end

@implementation ELKEasyTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"easy timer";
    
    self.view.elk_setBackgroundColor(UIColor.whiteColor)
    .elk_addSubview(self.timeBtn1)
    .elk_addSubview(self.timeBtn2);
    
    
}

- (void)elk_easyTimerEvent:(ELKEasyTimer *)timer step:(NSInteger)stepCount
{
    self.timeBtn2.elk_setTitleForNormal([NSString stringWithFormat:@"剩余%lds", (long)stepCount]);
    if (stepCount == 0) {
        self.timeBtn2.elk_setTitleForNormal(@"定时器代理事件")
        .elk_setEnabled(YES);
    }
}

- (UIButton *)timeBtn1
{
    return _timeBtn1 ?: ({
        _timeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeBtn1.elk_setTitleForNormal(@"定时器Block事件")
        .elk_setTitleColorForNormal(ELK_HexColor(0x333333, 1.f))
        .elk_setTitleLabelFont([UIFont systemFontOfSize:12])
        .elk_addTargetBlock(UIControlEventTouchUpInside, ^(UIButton * _Nonnull sender) {
            sender.elk_setTitleForNormal(@"剩余5s")
            .elk_setEnabled(NO);
            [ELKEasyTimer elk_easyTimeInterval:1 repeat:5 block:^(ELKEasyTimer * _Nonnull timer, NSInteger stepCount) {
                sender.elk_setTitleForNormal([NSString stringWithFormat:@"剩余%lds", (long)stepCount]);
                if (stepCount == 0) {
                    sender.elk_setTitleForNormal(@"定时器Block事件")
                    .elk_setEnabled(YES);
                }
            }];
        })
        .elk_setFrameMake(40.f, 120.f, 120.f, 30.f)
        .elk_setBackgroundColor(UIColor.orangeColor);
        _timeBtn1;
    });
}

- (UIButton *)timeBtn2
{
    return _timeBtn2 ?: ({
        _timeBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeBtn2.elk_setTitleForNormal(@"定时器代理事件")
        .elk_setTitleColorForNormal(ELK_HexColor(0x333333, 1.f))
        .elk_setTitleLabelFont([UIFont systemFontOfSize:12])
        .elk_addTargetBlock(UIControlEventTouchUpInside, ^(UIButton * _Nonnull sender) {
            sender.elk_setTitleForNormal(@"剩余6s")
            .elk_setEnabled(NO);
            [ELKEasyTimer elk_easyTimeInterval:1 repeat:6 delegate:self];
        })
        .elk_setFrameMake(40.f, 160.f, 120.f, 30.f)
        .elk_setBackgroundColor(UIColor.orangeColor);
        _timeBtn2;
    });
}



@end
