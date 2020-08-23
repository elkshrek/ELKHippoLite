//
//  UITextField+HZEditControl.m
//  ObserveTest
//
//  Created by newmac on 2019/5/29.
//  Copyright © 2019 newmac. All rights reserved.
//

#import "UITextField+HZEditControl.h"
#import <objc/runtime.h>

@interface UITextField()

@property (nonatomic, assign) BOOL hz_isSetupSelectors;
@property (nonatomic, copy) void(^hz_editingChangedBlock)(UITextField *textField, NSString *text);
@property (nonatomic, copy) void(^hz_editingEndBlock)(UITextField *textField, NSString *text);


@end

@implementation UITextField (HZEditingControl)

- (void)hz_setupEditingChangedBlock:(void (^)(UITextField * _Nonnull, NSString * _Nonnull))block {
    [self hz_setupSelectorsIfNeed];
    self.hz_editingChangedBlock = block;
}

- (void)hz_setupEditingEndBlock:(void (^)(UITextField * _Nonnull, NSString * _Nonnull))block {
    [self hz_setupSelectorsIfNeed];
    self.hz_editingEndBlock = block;
}

- (void)hz_setupSelectorsIfNeed {
    if (!self.hz_isSetupSelectors) {
        [self addTarget:self action:@selector(hz_handleEditingChanged) forControlEvents:UIControlEventEditingChanged];
        [self addTarget:self action:@selector(hz_handleEditingEnd) forControlEvents:UIControlEventEditingDidEnd];
        self.hz_isSetupSelectors = YES;
    }
}

- (void)hz_handleEditingChanged {
    if (self.hz_editingChangedBlock) {
        self.hz_editingChangedBlock(self, self.text);
    }
}

- (void)hz_handleEditingEnd {
    if (self.hz_editingEndBlock) {
        self.hz_editingEndBlock(self, self.text);
    }
}

- (void)setHz_editingEndBlock:(void (^)(UITextField *, NSString *))hz_editingEndBlock {
    objc_setAssociatedObject(self, @selector(hz_editingEndBlock), hz_editingEndBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITextField *, NSString *))hz_editingEndBlock {
    return objc_getAssociatedObject(self, @selector(hz_editingEndBlock));
}

- (void)setHz_editingChangedBlock:(void (^)(UITextField *, NSString *))hz_editingChangedBlock {
    objc_setAssociatedObject(self, @selector(hz_editingChangedBlock), hz_editingChangedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITextField *, NSString *))hz_editingChangedBlock {
    return objc_getAssociatedObject(self, @selector(hz_editingChangedBlock));
}

- (void)setHz_isSetupSelectors:(BOOL)hz_isSetupSelectors
{
    objc_setAssociatedObject(self, @selector(hz_isSetupSelectors), @(hz_isSetupSelectors), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hz_isSetupSelectors
{
    return [objc_getAssociatedObject(self, @selector(hz_isSetupSelectors)) boolValue];
}

@end
