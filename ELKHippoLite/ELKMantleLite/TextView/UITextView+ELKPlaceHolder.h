//
//  UITextView+ELKPlaceHolder.h
//  ELKParallel
//
//  Created by Jonathan on 2019/4/1.
//  Copyright © 2019 elk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ELKTextViewDidChangeBlock)(NSString * _Nullable text, BOOL relFull);

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (ELKPlaceHolder)

/**
 The string that is displayed when there is no other text in the text view.
 */
@property (nonatomic, copy) NSString *placeHolder;
/**
 The placeholder's Color
 */
@property (nonatomic, strong) UIColor *placeHolderColor;
/**
 The Maximum Length Of Text
*/
@property (nonatomic, assign) NSInteger maxTextLength;
/**
 Notify when textview did changed
 */
@property (nonatomic, copy) ELKTextViewDidChangeBlock textViewDidChangeBlock;


@end

NS_ASSUME_NONNULL_END
