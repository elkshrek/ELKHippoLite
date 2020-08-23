//
//  UITextView+ELKPlaceHolder.m
//  ELKParallel
//
//  Created by Jonathan on 2019/4/1.
//  Copyright © 2019 elk. All rights reserved.
//

#import "UITextView+ELKPlaceHolder.h"
#import <objc/runtime.h>

static const char *elkPlaceHolderTextView = "elkPlaceHolderTextView";
static const char *elkPlaceHolderColor    = "elkPlaceHolderColor";
static const char *elkPlaceHolder         = "elkPlaceHolder";
static const char *elkMaximumTextLength   = "elkMaximumTextLength";

@interface UITextView ()

@property (nonatomic, strong) UITextView *placeHolderTextView;

@end

@implementation UITextView (ELKPlaceHolder)

- (UITextView *)placeHolderTextView
{
    UITextView *textView = objc_getAssociatedObject(self, elkPlaceHolderTextView);
    if (!textView) {
        textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.f];
        textView.userInteractionEnabled = NO;
        [textView setEditable:NO];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(elk_textViewDidBeginEditing) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(elk_textViewDidEndEditing) name:UITextViewTextDidEndEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(elk_textViewDidChange) name:UITextViewTextDidChangeNotification object:nil];
        [self addSubview:textView];
        [self setPlaceHolderTextView:textView];
    }
    
    return textView;
}

- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView
{
    objc_setAssociatedObject(self, elkPlaceHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)elk_setFont:(UIFont *)font
{
    [self elk_setFont:font];
    [self.placeHolderTextView elk_setFont:font];
}

- (void)elk_setText:(NSString *)text
{
    [self elk_setText:text];
    self.placeHolderTextView.hidden = text.length;
}

- (NSString *)placeHolder
{
    NSString *pholderString = objc_getAssociatedObject(self, elkPlaceHolder);
    if (!pholderString) {
        pholderString = @"";
        [self setPlaceHolder:pholderString];
    }
    return pholderString;
}
- (void)setPlaceHolder:(NSString *)placeHolder
{
    objc_setAssociatedObject(self, elkPlaceHolder, placeHolder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.placeHolderTextView elk_setText:placeHolder];
}

- (UIColor *)placeHolderColor
{
    UIColor *phColor = objc_getAssociatedObject(self, elkPlaceHolderColor);
    if (!phColor) {
        phColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.f];
        [self setPlaceHolderColor:phColor];
    }
    return phColor;
}
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    objc_setAssociatedObject(self, elkPlaceHolderColor, placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.placeHolderTextView.textColor = placeHolderColor;
}

- (void)setMaxTextLength:(NSInteger)maxTextLength
{
    if (maxTextLength <= 0) {
        maxTextLength = floorl(MAXFLOAT);
    }
    objc_setAssociatedObject(self, elkMaximumTextLength, [NSNumber numberWithInteger:maxTextLength], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)maxTextLength
{
    NSNumber *maximum = objc_getAssociatedObject(self, elkMaximumTextLength);
    if (!maximum) {
        maximum = [NSNumber numberWithInteger:floorl(MAXFLOAT)];
        [self setMaxTextLength:[maximum integerValue]];
    }
    return [maximum integerValue];
}

- (ELKTextViewDidChangeBlock)textViewDidChangeBlock
{
    return objc_getAssociatedObject(self, @selector(textViewDidChangeBlock));
}
- (void)setTextViewDidChangeBlock:(ELKTextViewDidChangeBlock)textViewDidChangeBlock
{
    objc_setAssociatedObject(self, @selector(textViewDidChangeBlock), textViewDidChangeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)elk_textViewDidBeginEditing
{
    self.placeHolderTextView.hidden = self.text.length;
}
- (void)elk_textViewDidEndEditing
{
    self.placeHolderTextView.hidden = self.text.length;
}
- (void)elk_textViewDidChange
{
    NSString *toBeString = self.text;
    
    NSArray *current = [UITextInputMode activeInputModes];
    UITextInputMode *currentInputMode = [current firstObject];
    NSString *lang = [currentInputMode primaryLanguage];
    NSInteger maxTextLength = self.maxTextLength;
    
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > maxTextLength) {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxTextLength];
                if (rangeIndex.length == 1) {
                    [self elk_setText:[toBeString substringToIndex:maxTextLength]];
                } else {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxTextLength)];
                    [self elk_setText:[toBeString substringWithRange:rangeRange]];
                }
            }
            if (toBeString.length) {
                if (self.textViewDidChangeBlock) {
                    self.textViewDidChangeBlock(self.text, YES);
                }
            }
        }
        if (self.textViewDidChangeBlock) {
            self.textViewDidChangeBlock(self.text, NO);
        }
    } else {
        if (toBeString.length > maxTextLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxTextLength];
            if (rangeIndex.length == 1) {
                [self elk_setText:[toBeString substringToIndex:maxTextLength]];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxTextLength)];
                [self elk_setText:[toBeString substringWithRange:rangeRange]];
            }
        }
        if (self.textViewDidChangeBlock) {
            self.textViewDidChangeBlock(self.text, YES);
        }
    }
    self.placeHolderTextView.hidden = self.text.length;
    
}

+ (void)load
{
    [super load];
    
    [UITextView elkExchMethodWithClass:self oriMethod:@selector(setFont:) newMethod:@selector(elk_setFont:)];
    
    [UITextView elkExchMethodWithClass:self oriMethod:@selector(setText:) newMethod:@selector(elk_setText:)];
    
}

+ (void)elkExchMethodWithClass:(id)objClass oriMethod:(SEL)oriSel newMethod:(SEL)newSel
{
    Method fromMethod = class_getInstanceMethod([objClass class], oriSel);
    Method toMethod = class_getInstanceMethod([objClass class], newSel);
    
    if (!class_addMethod([objClass class], oriSel, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
