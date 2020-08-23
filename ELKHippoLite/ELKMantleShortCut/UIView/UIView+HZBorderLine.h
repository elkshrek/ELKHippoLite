//
//  UIView+HZBorderLine.h
//  ObserveTest
//
//  Created by newmac on 2019/6/3.
//  Copyright © 2019 newmac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HZBorderLine)

@property (nonatomic, assign) BOOL hz_isLineOutside;
@property (nonatomic, strong) UIColor *hz_borderlineColor;
@property (nonatomic, assign) UIRectEdge hz_borderEdge;

@property (nonatomic, assign) CGFloat hz_leftMargin; // 左间距
@property (nonatomic, assign) CGFloat hz_rightMargin; // 右间距


@end

NS_ASSUME_NONNULL_END
