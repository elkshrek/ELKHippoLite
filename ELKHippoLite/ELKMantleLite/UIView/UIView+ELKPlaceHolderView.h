//
//  UIView+ElkPlaceHolderView.h
//  ZJTableView
//
//  Created by Maybe on 2020/5/18.
//  Copyright © 2020 maybe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ELKPlaceHolderTouchBlock)(UIButton *sender);

@interface UIView (ELKPlaceHolderView)


@property (nonatomic, strong, nullable) UIView *elkPlaceHolderView;



/// 添加占位图
/// @param image 图片
/// @param updateViews 更新UI
- (UIView *)elkShowPlaceHolderViewWithImage:(UIImage *)image updateViews:(void(^)(UIImageView *imageView))updateViews;

/// 添加占位图与文本
/// @param image 图片
/// @param title 文本
/// @param updateViews 更新UI
- (UIView *)elkShowPlaceHolderViewWithImage:(UIImage *)image title:(nullable NSString *)title updateViews:(void(^)(UIImageView *imageView, UILabel *titleLabel))updateViews;


/// 添加占位图与文本加按钮
/// @param image 图片
/// @param title 文本
/// @param buttonTitle 按钮title 为空则不会创建按钮
/// @param updateViews 更新UI
/// @param touchBlock 按钮事件
- (UIView *)elkShowPlaceHolderViewWithImage:(UIImage *)image title:(nullable NSString *)title buttonTitle:(nullable NSString *)buttonTitle updateViews:(void(^)(UIImageView *imageView, UILabel *titleLabel, UIButton *button))updateViews touchBlock:(nullable ELKPlaceHolderTouchBlock)touchBlock ;


/// 移除占位图
- (void)elk_removePlaceholderView ;

@end

NS_ASSUME_NONNULL_END
