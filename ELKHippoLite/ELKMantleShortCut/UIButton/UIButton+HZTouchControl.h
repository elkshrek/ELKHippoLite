//
//  UIButton+HZTouchControl.h
//  ObserveTest
//
//  Created by newmac on 2019/5/29.
//  Copyright © 2019 newmac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HZTouchControl)

/** 设置button高亮回调 */
- (void)hz_setupTouchHighlightBlock:(void(^)(UIButton *button, BOOL isHighlight))block;

/** 设置button 点击回调*/
- (void)hz_setupTouchUpInsideBlock:(void(^)(UIButton *button))block;

@end

NS_ASSUME_NONNULL_END
