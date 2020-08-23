//
//  UITextField+ELKEvent.h
//  ELKCommonDemo
//
//  Created by HuangZile on 2020/6/3.
//  Copyright © 2020 wing. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (ELKEvent)

///获取textField光标位置
- (NSRange)elk_selectedRange;

///设置 textField光标位置
- (void)elk_setSelectedRange:(NSRange) range;

@end

NS_ASSUME_NONNULL_END
