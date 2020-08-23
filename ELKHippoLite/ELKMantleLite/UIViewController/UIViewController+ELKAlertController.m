//
//  UIViewController+ELKAlertController.m
//  ELKParallel
//
//  Created by wing on 2019/12/30.
//  Copyright © 2019 wing. All rights reserved.
//

#import "UIViewController+ELKAlertController.h"

@implementation UIViewController (ELKAlertController)


/**
 UIAlertController, just cancel
 
 @param title    title
 @param message  message
 */
- (void)alertControllerTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message
{
    [self alertControllerTitle:title message:message cancel:@"取消" cancelBlock:nil submit:nil submitBlock:nil];
}


/**
 UIAlertController, complete just response submit
 
 @param title     title
 @param cancel    cancel title
 @param submit    submit title
 @param subBlock  submit event
 */
- (void)alertControllerTitle:(NSString *_Nullable)title cancel:(NSString *_Nullable)cancel submit:(NSString * _Nullable)submit subBlock:(void (^ _Nullable)(void))subBlock
{
    [self alertControllerTitle:title message:nil cancel:cancel cancelBlock:nil submit:submit submitBlock:subBlock];
}


/**
 UIAlertController, response the event of cancel and submit
 
 @param title     title
 @param cancel    cancel title
 @param calBlock  cancel event
 @param submit    submit title
 @param subBlock  submit event
 */
- (void)alertControllerTitle:(NSString *_Nullable)title cancel:(NSString *_Nullable)cancel cancelBlock:(void(^_Nullable)(void))calBlock submit:(NSString *_Nullable)submit submitBlock:(void(^_Nullable)(void))subBlock
{
    [self alertControllerTitle:title message:nil cancel:cancel cancelBlock:calBlock submit:submit submitBlock:subBlock];
}


/**
UIAlertController, complete just response submit

@param title     title
@param message   message
@param cancel    cancel title
@param submit    submit title
@param subBlock  submit event
*/
- (void)alertControllerTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message cancel:(NSString *_Nullable)cancel submit:(NSString * _Nullable)submit subBlock:(void (^ _Nullable)(void))subBlock
{
    [self alertControllerTitle:title message:message cancel:cancel cancelBlock:nil submit:submit submitBlock:subBlock];
}


/**
 UIAlertController, response the event of cancel and submit
 
 @param title     title
 @param message   message
 @param cancel    cancel title
 @param calBlock  cancel event
 @param submit    submit title
 @param subBlock  submit event
 */
- (void)alertControllerTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message cancel:(NSString *_Nullable)cancel cancelBlock:(void(^_Nullable)(void))calBlock submit:(NSString *_Nullable)submit submitBlock:(void(^_Nullable)(void))subBlock;
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertCon addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (calBlock) {
            calBlock();
        }
    }]];
    if (submit && submit.length) {
        [alertCon addAction:[UIAlertAction actionWithTitle:submit style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (subBlock) {
                subBlock();
            }
        }]];
    }
    [self presentViewController:alertCon animated:YES completion:nil];
}








@end
