//
//  UIView+ElkPlaceHolderView.m
//  ZJTableView
//
//  Created by Maybe on 2020/5/18.
//  Copyright © 2020 maybe. All rights reserved.
//

#import "UIView+ELKPlaceHolderView.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

static char ELKPlaceHolderViewTag;
static char ELKPlaceHolderTouchBlockTag;

@interface UIView ()
@property (nonatomic, copy) ELKPlaceHolderTouchBlock elkPlaceHolderTouchBlock;

@end

@implementation UIView (ELKPlaceHolderView)

#pragma mark -  关联对象
- (UIView *)elkPlaceHolderView {
    
    return objc_getAssociatedObject(self, &ELKPlaceHolderViewTag);
}

- (void)setElkPlaceHolderView:(UIView * )elkPlaceHolderView {
    objc_setAssociatedObject(self, &ELKPlaceHolderViewTag,
                             elkPlaceHolderView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
 
- (ELKPlaceHolderTouchBlock)elkPlaceHolderTouchBlock {
    return objc_getAssociatedObject(self, &ELKPlaceHolderTouchBlockTag);
}
 
- (void)setElkPlaceHolderTouchBlock:(ELKPlaceHolderTouchBlock)elkPlaceHolderTouchBlock {
    
    objc_setAssociatedObject(self, &ELKPlaceHolderTouchBlockTag, elkPlaceHolderTouchBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark -  UIView的占位图
- (UIView *)elkShowPlaceHolderViewWithImage:(UIImage *)image updateViews:(void(^)(UIImageView *imageView))updateViews  {
    
    return  [self elkShowPlaceHolderViewWithImage:image title:nil buttonTitle:nil updateViews:^(UIImageView *imageView, UILabel *titleLabel, UIButton *button) {
        updateViews(imageView);
    } touchBlock:nil];
    
}
- (UIView *)elkShowPlaceHolderViewWithImage:(UIImage *)image title:(nullable NSString *)title updateViews:(void(^)(UIImageView *imageView, UILabel *titleLabel))updateViews {
    return  [self elkShowPlaceHolderViewWithImage:image title:title buttonTitle:nil updateViews:^(UIImageView *imageView, UILabel *titleLabel, UIButton *button) {
        updateViews(imageView,titleLabel);
    } touchBlock:nil];
    
}


- (UIView *)elkShowPlaceHolderViewWithImage:(UIImage *)image title:(nullable NSString * )title buttonTitle:(nullable  NSString *  )buttonTitle updateViews:(void(^)(UIImageView *imageView, UILabel *titleLabel, UIButton *button))updateViews touchBlock:(nullable ELKPlaceHolderTouchBlock)touchBlock {
    if (self.elkPlaceHolderView) {
          [self.elkPlaceHolderView removeFromSuperview];
          self.elkPlaceHolderView = nil;
      }
    self.elkPlaceHolderView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.elkPlaceHolderView];
    self.elkPlaceHolderView.backgroundColor = [UIColor whiteColor];
      
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
//    if (image.size.width > self.frame.size.width || )
    
    imageView.image = image;
    imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    [self.elkPlaceHolderView addSubview:imageView];
    
    UILabel *titleLabel;
    if (title) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        [titleLabel sizeToFit];
        titleLabel.center =  CGPointMake(self.frame.size.width/2, CGRectGetMaxY(imageView.frame) +titleLabel.frame.size.height/2 + 10);
        [self.elkPlaceHolderView addSubview:titleLabel];
         
    }
    UIButton *button;
    if (buttonTitle) {
        button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        CGFloat topY =  MAX(CGRectGetMaxY(imageView.frame), CGRectGetMaxY(titleLabel.frame));
        button.center =  CGPointMake(self.frame.size.width/2, topY +button.frame.size.height/2 + 10);
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.elkPlaceHolderView addSubview:button];
    }

    self.elkPlaceHolderTouchBlock = touchBlock;
    updateViews(imageView,titleLabel,button);
    return self.elkPlaceHolderView;
}


/// 按钮事件
/// @param button button
- (void)buttonTouchAction:(UIButton *)button {
    
    if (self.elkPlaceHolderTouchBlock) {
        self.elkPlaceHolderTouchBlock(button);
    }
}


- (void)elk_removePlaceholderView {
    if (self.elkPlaceHolderView) {
        [self.elkPlaceHolderView removeFromSuperview];
        self.elkPlaceHolderView = nil;
    }
 
}



@end
