//
//  UIViewController+ELKImagePicker.h
//  ELKHaiTouClient
//
//  Created by wing on 2020/4/23.
//  Copyright © 2020 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ELKPickerImageComplete)(UIImage *_Nonnull image);

@interface UIViewController (ELKImagePicker)



/// 从系统相册或相机获取照片
/// @param allowEdit 是否需要编辑
/// @param complete  数据反馈
- (void)elk_pickImageAllowEdit:(BOOL)allowEdit complete:(ELKPickerImageComplete)complete;




@end

NS_ASSUME_NONNULL_END
