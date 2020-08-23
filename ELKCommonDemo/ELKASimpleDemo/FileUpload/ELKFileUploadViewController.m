//
//  ELKFileUploadViewController.m
//  ELKCommonDemo
//
//  Created by wing on 2020/6/18.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKFileUploadViewController.h"
#import "UIViewController+ELKImagePicker.h"
#import "ELKRequestTool.h"
#import <AVKit/AVKit.h>

typedef NS_OPTIONS(NSUInteger, ELKFileSelectType) {
    /// 选择图片
    ELKFileSelectTypePic   = 1 << 0,
    /// 选择视频
    ELKFileSelectTypeVideo = 1 << 1,
};

@interface ELKFileUploadViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ELKFileUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.elk_setBackgroundColor(UIColor.whiteColor);
    
    UIButton *picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    picBtn.elk_setTitleForNormal(@"select pic")
    .elk_setFrame(CGRectMake(30.f, 100.f, 140.f, 40.f))
    .elk_setBackgroundColor(UIColor.redColor)
    .elk_addTarget(self, @selector(selectPic:), UIControlEventTouchUpInside);
    self.view.elk_addSubview(picBtn);
    
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    videoBtn.elk_setTitleForNormal(@"select video")
    .elk_setFrame(CGRectMake(30.f, 160.f, 140.f, 40.f))
    .elk_setBackgroundColor(UIColor.redColor)
    .elk_addTarget(self, @selector(selectVideo:), UIControlEventTouchUpInside);
    self.view.elk_addSubview(videoBtn);
    
    [ELKNetworkManager elk_setAliOSSInfo:[ELKAliOSSInfoModel elk_aliOSSAccess:@"LTAI4FxVsGN1aswuD3Dt9fx2" secret:@"hBcnCoWtC4eKBPp5oLwZzK415x0QcT" endPoint:nil bucket:@"efeiyanka"]];
    
    
}


- (void)selectPic:(UIButton *)sender
{
    [self elk_imagePickerSheet:ELKFileSelectTypePic];
}
- (void)selectVideo:(UIButton *)sender
{
    [self elk_imagePickerSheet:ELKFileSelectTypeVideo];
}

/// 选择图片的alert弹框
- (void)elk_imagePickerSheet:(ELKFileSelectType)selType
{
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertSheet addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (selType == ELKFileSelectTypePic) {
            [self elk_openImagePicker:UIImagePickerControllerSourceTypeCamera];
        } else {
            [self elk_openVideoPicker:UIImagePickerControllerSourceTypeCamera];
        }
    }]];
    [alertSheet addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (selType == ELKFileSelectTypePic) {
            [self elk_openImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
        } else {
            [self elk_openVideoPicker:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        }
    }]];
    [alertSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertSheet animated:YES completion:nil];
}

/// 选图片
- (void)elk_openImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
// 选视频
- (void)elk_openVideoPicker:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    picker.videoMaximumDuration = 15;//视频最长长度
    picker.videoQuality = UIImagePickerControllerQualityTypeMedium;//视频质量
    picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];

    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.movie"]){
        // 视频
        NSURL *url = info[UIImagePickerControllerMediaURL];
        NSLog(@"url %@",url);
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
        ELKUploadFileInfoModel *fileModel = [ELKUploadFileInfoModel elk_fileInfo:asset path:@"video/"];
        [ELKRequestTool elk_ossUpload:fileModel progress:^(CGFloat progress) {
            NSLog(@"video upload progress %f", progress);
        } success:^(NSString * _Nonnull mediaUrl, BOOL status) {
            NSLog(@"video url %@", mediaUrl);
        } failure:^(NSError * _Nullable error) {
            NSLog(@"video upload failure");
        }];
    } else {
        // 图片
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        ELKUploadFileInfoModel *fileModel = [ELKUploadFileInfoModel elk_fileInfo:img path:@"picture/"];
        [ELKRequestTool elk_ossUpload:fileModel progress:^(CGFloat progress) {
            NSLog(@"picture upload progress %f", progress);
        } success:^(NSString * _Nonnull mediaUrl, BOOL status) {
            NSLog(@"picture url %@", mediaUrl);
        } failure:^(NSError * _Nullable error) {
            NSLog(@"picture upload failure");
        }];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
