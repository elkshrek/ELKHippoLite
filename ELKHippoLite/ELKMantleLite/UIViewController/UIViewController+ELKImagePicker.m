//
//  UIViewController+ELKImagePicker.m
//  ELKHaiTouClient
//
//  Created by wing on 2020/4/23.
//  Copyright © 2020 wing. All rights reserved.
//

#import "UIViewController+ELKImagePicker.h"
#import <objc/runtime.h>

@interface UIViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSNumber *elk_allowEdit;
@property (nonatomic, copy) ELKPickerImageComplete elkPickerComplete;

@end

@implementation UIViewController (ELKImagePicker)


/// 从系统相册或相机获取照片
- (void)elk_pickImageAllowEdit:(BOOL)allowEdit complete:(ELKPickerImageComplete)complete
{
    self.elk_allowEdit = @(allowEdit);
    self.elkPickerComplete = complete;
    [self elk_selectImageSheet];
}


/// 选择图片的alert弹框
- (void)elk_selectImageSheet
{
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertSheet addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self elk_openImagePicker:UIImagePickerControllerSourceTypeCamera];
    }]];
    [alertSheet addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self elk_openImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [alertSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertSheet animated:YES completion:nil];
}

/// 打开相册或者相机
- (void)elk_openImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    picker.allowsEditing = [self.elk_allowEdit boolValue];
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImagePickerControllerInfoKey pickContKey = [self.elk_allowEdit boolValue] ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage;
    UIImage *image = [info objectForKey:pickContKey];
    if (self.elkPickerComplete) {
        self.elkPickerComplete(image);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSNumber *)elk_allowEdit
{
    return objc_getAssociatedObject(self, @selector(elk_allowEdit));
}
- (void)setElk_allowEdit:(NSNumber *)elk_allowEdit
{
    objc_setAssociatedObject(self, @selector(elk_allowEdit), elk_allowEdit, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ELKPickerImageComplete)elkPickerComplete
{
    return objc_getAssociatedObject(self, @selector(elkPickerComplete));
}
- (void)setElkPickerComplete:(ELKPickerImageComplete)elkPickerComplete
{
    objc_setAssociatedObject(self, @selector(elkPickerComplete), elkPickerComplete, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
