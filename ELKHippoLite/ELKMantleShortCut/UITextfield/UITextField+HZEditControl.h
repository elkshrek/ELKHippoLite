//
//  UITextField+HZEditControl.h
//  ObserveTest
//
//  Created by newmac on 2019/5/29.
//  Copyright © 2019 newmac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (HZEditingControl)


/** 编辑事件回调 */
- (void)hz_setupEditingChangedBlock:(void(^)(UITextField *textField, NSString *text))block;

/** 编辑完成回调 */
- (void)hz_setupEditingEndBlock:(void(^)(UITextField *textField, NSString *text))block;

@end

NS_ASSUME_NONNULL_END
