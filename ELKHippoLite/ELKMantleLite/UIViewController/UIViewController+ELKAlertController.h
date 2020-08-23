//
//  UIViewController+ELKAlertController.h
//  ELKParallel
//
//  Created by wing on 2019/12/30.
//  Copyright © 2019 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ELKAlertController)

/**
 UIAlertController, just cancel
 
 @param title    title
 @param message  message
 */
- (void)alertControllerTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message;


/**
 UIAlertController, complete just response submit

 @param title     title
 @param cancel    cancel title
 @param submit    submit title
 @param subBlock  submit event
 */
- (void)alertControllerTitle:(NSString *_Nullable)title cancel:(NSString *_Nullable)cancel submit:(NSString *_Nullable)submit subBlock:(void(^_Nullable)(void))subBlock;


/**
 UIAlertController, response the event of cancel and submit
 
 @param title     title
 @param cancel    cancel title
 @param calBlock  cancel event
 @param submit    submit title
 @param subBlock  submit event
 */
- (void)alertControllerTitle:(NSString *_Nullable)title cancel:(NSString *_Nullable)cancel cancelBlock:(void(^_Nullable)(void))calBlock submit:(NSString *_Nullable)submit submitBlock:(void(^_Nullable)(void))subBlock;


/**
 UIAlertController, complete just response submit

 @param title     title
 @param message   message
 @param cancel    cancel title
 @param submit    submit title
 @param subBlock  submit event
 */
- (void)alertControllerTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message cancel:(NSString *_Nullable)cancel submit:(NSString *_Nullable)submit subBlock:(void(^_Nullable)(void))subBlock;


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











@end

NS_ASSUME_NONNULL_END
