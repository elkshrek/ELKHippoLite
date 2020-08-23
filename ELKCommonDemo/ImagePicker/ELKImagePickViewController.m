//
//  ELKImagePickViewController.m
//  ELKCommonDemo
//
//  Created by wing on 2020/5/8.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKImagePickViewController.h"
#import "ELKSelPictureView.h"

@interface ELKImagePickViewController ()

@property (nonatomic, strong) ELKSelPictureView *selPicView;

@property (nonatomic, assign) NSInteger selPicIndex;

@end

@implementation ELKImagePickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    e_weakify(self);
    self.view.elk_addSubview(self.selPicView)
    .elk_setBackgroundColor(UIColor.whiteColor);
    self.selPicView.selectBlock = ^(NSIndexPath * _Nonnull indexPath) {
        e_strongify(self);
        self.selPicIndex = indexPath.row;
        [self selectPicAlert];
    };
        
        
        
}

- (void)selectPicAlert
{
    e_weakify(self);
    [self elk_pickImageAllowEdit:NO complete:^(UIImage * _Nonnull image) {
        if (image) {
            e_strongify(self);
            [self.selPicView selectImage:image imageUrl:nil index:self.selPicIndex];
        }
    }];
}

- (ELKSelPictureView *)selPicView
{
    return _selPicView ?: ({
        _selPicView = [[ELKSelPictureView alloc] initWithFrame:CGRectMake(30.f, 150.f, ELKScreenWidth - 60.f, 70.f)];
        _selPicView.elk_setBackgroundColor(UIColor.orangeColor);
        _selPicView;
    });
}



@end
