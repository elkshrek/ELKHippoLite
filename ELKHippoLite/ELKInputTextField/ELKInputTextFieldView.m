//
//  ELKInputTextFieldView.m
//  ELKCommonDemo
//
//  Created by HuangZile on 2020/6/3.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKInputTextFieldView.h"

#import <Masonry/Masonry.h>
#import "UITextField+HZEditControl.h"
#import "UITextField+HZAppearance.h"
#import "UITextField+ELKEvent.h"

#define kNumberString @"0123456789"
#define kIDCardString @"0123456789Xx"
#define kLetterString @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

@interface ELKInputTextFieldView()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
//@property (nonatomic, assign) ELKInputTextFieldType textFieldType;

///保存上一次文本输入内容
@property (nonatomic, copy) NSString *lastTextFieldConent;


@end

@implementation ELKInputTextFieldView

- (instancetype)initWithFrame:(CGRect)frame textFieldType:(ELKInputTextFieldType)textFieldType {
    if (self = [super initWithFrame:frame]) {
        self.textField = [[UITextField alloc] init];
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.placeholder = [self placeholderWithType:textFieldType];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
       self.textFieldType = textFieldType;
        [self.textField hz_setupEditingChangedBlock:^(UITextField * _Nonnull textField, NSString * _Nonnull text) {
            [self handleTextField:textField text:text];
        }];
        [self addSubview:self.textField];
    }
    return self;
}

- (void)setTextFieldType:(ELKInputTextFieldType)textFieldType {
    _textFieldType = textFieldType;
    [self updateTextField];
}

- (void)updateTextField {
    self.textField.text = nil;
    self.lastTextFieldConent = @"";
    self.textField.placeholder = [self placeholderWithType:self.textFieldType];
    if (self.textFieldType == ELKInputTextFieldPassword) {
        self.textField.secureTextEntry = YES;
        self.contentType = ELKInputTextFieldLetter | ELKInputTextFieldSpot | ELKInputTextFieldNumber;
    } else {
        self.textField.secureTextEntry = NO;
    }
}

- (void)handleTextField:(UITextField *)textField text:(NSString *)text {
    if (self.textFieldType == ELKInputTextFieldPhone) {
        if (![self elk_isValidLimitString:kNumberString string:text]) {
            self.textField.text = self.lastTextFieldConent;
        } else {
            self.lastTextFieldConent = text;
        }
        [self elk_isValidLimitTextField:textField string:text limitNumber:11];
        
    } else if (self.textFieldType == ELKInputTextFieldIDCard) {
        if (![self elk_isValidLimitString:kIDCardString string:text]) {
            self.textField.text = self.lastTextFieldConent;
        } else {
            self.lastTextFieldConent = text;
        }
        [self elk_isValidLimitTextField:textField string:text limitNumber:18];

    } else if (self.textFieldType == ELKInputTextFieldBankCard) {
        if (![self elk_isValidLimitString:kNumberString string:text]) {
            self.textField.text = self.lastTextFieldConent;
        } else {
            self.lastTextFieldConent = text;
        }
        [self elk_isValidLimitTextField:textField string:text limitNumber:19];

    } else if (self.textFieldType == ELKInputTextFieldPassword) {
        NSInteger number = self.limitNumber ? self.limitNumber : 6;
        NSMutableString *limitString = [NSMutableString string];
        if (self.contentType & ELKInputTextFieldNumber) {
            [limitString appendString:kNumberString];
        }
        if (self.contentType & ELKInputTextFieldLetter) {
            [limitString appendString:kLetterString];
        }
        if (self.contentType & ELKInputTextFieldSpot) {
            [limitString appendString:@"."];
        }
        if (![self elk_isValidLimitString:limitString string:text]) {
            self.textField.text = self.lastTextFieldConent;
        } else {
            self.lastTextFieldConent = text;
        }
        [self elk_isValidLimitTextField:textField string:text limitNumber:number];
    
    } else if (self.textFieldType == ELKInputTextFieldVaildCode) {
        if (![self elk_isValidLimitString:kNumberString string:text]) {
            self.textField.text = self.lastTextFieldConent;
        } else {
            self.lastTextFieldConent = text;
        }
        NSInteger number = self.limitNumber ? self.limitNumber : 6;
        [self elk_isValidLimitTextField:textField string:text limitNumber:number];
    
    } else if (self.textFieldType == ELKInputTextFieldText) {
        NSInteger number = self.limitNumber ? self.limitNumber : 20;
        [self elk_isValidLimitTextField:textField string:text limitNumber:number];
    }
}

///返回placeholder
- (NSString *)placeholderWithType:(ELKInputTextFieldType)type {
    NSString *string;
    switch (type) {
        case ELKInputTextFieldPhone: {
            string = @"请输入手机号码";
        }
            break;
        case ELKInputTextFieldEmali: {
            string = @"请输入邮箱地址";

        }
            break;
        case ELKInputTextFieldIDCard: {
            string = @"请输入身份证号";

        }
            break;
        case ELKInputTextFieldPassword: {
            string = @"请输入密码";

        }
            break;
        case ELKInputTextFieldVaildCode: {
            string = @"请输入验证码";

        }
            break;
        case ELKInputTextFieldBankCard: {
            string = @"请输入银行卡号";

        }
            break;
        default:
            break;
    }
    return string;
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textField.frame = UIEdgeInsetsInsetRect(self.bounds, self.contentInset);
}

- (BOOL)elk_isContentTextFieldValid {
    return ![self elk_isContentEmpty] && [self elk_isContentCanMatch];
}

- (BOOL)elk_isContentEmpty {
    return self.textField.text.length == 0;
}

- (BOOL)elk_isContentCanMatch {
    if (self.textFieldType == ELKInputTextFieldPhone) {
        NSString *phoneRegex = @"1[3456789]\\d{9}$";
        NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
        return [carTest evaluateWithObject:self.textField.text];
           
    } else if (self.textFieldType == ELKInputTextFieldIDCard) {
        NSString *IDCardRegex = @"^[1-9]\\d{5}(18|19|20)\\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
        NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex];
        return [carTest evaluateWithObject:self.textField.text];
       
    } else if (self.textFieldType == ELKInputTextFieldBankCard) {
        NSString *phoneRegex = @"[0-9]{16,19}";
        NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
        return [carTest evaluateWithObject:self.textField.text];
        
    } else if (self.textFieldType == ELKInputTextFieldEmali) {
        NSString *emailRegex = @"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:self.textField.text];
    }
    return YES;
}

///监听输入内容
- (BOOL)elk_isValidLimitString:(NSString *)limitString string:(NSString *)string {
    if (string.length == 0) {
        return YES;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:limitString] invertedSet];
    BOOL basic = YES;
    for (NSInteger i = 0; i < string.length; i++) {
        NSString *charString = [string substringWithRange:NSMakeRange(i, 1)];
        NSString *filtered = [[charString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL match = [charString isEqualToString:filtered];
        if (!match) {
            basic = match;
            break;
        }
    }
    return basic;
}

///监听输入内容长度
- (void)elk_isValidLimitTextField:(UITextField *)textField string:(NSString *)string limitNumber:(NSInteger)limitNumber {
    NSRange range = [textField elk_selectedRange];
    if (range.location > limitNumber) {
        range = NSMakeRange(limitNumber, range.length);
    }//记录光标位置,当光标达到最大限制时,range location超出,手动控制
    if (textField.text.length >= limitNumber) {
        textField.text = [textField.text.mutableCopy substringWithRange:NSMakeRange(0, limitNumber)];
        [textField elk_setSelectedRange:range];
    }
}

///不使用代理方法
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (self.textFieldType == ELKInputTextFieldPhone) {
//        return [self elk_isValidLimitString:kNumberString string:string] && [self elk_isValidLimitTextField:textField string:string range:range limitNumber:11];
//
//    } else if (self.textFieldType == ELKInputTextFieldIDCard) {
//        return [self elk_isValidLimitString:kIDCardString string:string] && [self elk_isValidLimitTextField:textField string:string range:range limitNumber:18];
//
//    } else if (self.textFieldType == ELKInputTextFieldBankCard) {
//        return [self elk_isValidLimitString:kNumberString string:string] && [self elk_isValidLimitTextField:textField string:string range:range limitNumber:19];
//
//    } else if (self.textFieldType == ELKInputTextFieldPassword) {
//        NSInteger number = self.limitNumber ? self.limitNumber : 6;
//        NSMutableString *limitString = [NSMutableString string];
//        if (self.contentType & ELKInputTextFieldNumber) {
//            [limitString appendString:kNumberString];
//        }
//        if (self.contentType & ELKInputTextFieldLetter) {
//            [limitString appendString:kLetterString];
//        }
//        if (self.contentType & ELKInputTextFieldSpot) {
//            [limitString appendString:@"."];
//        }
//        return [self elk_isValidLimitString:limitString string:string] && [self elk_isValidLimitTextField:textField string:string range:range limitNumber:number];
//
//    } else if (self.textFieldType == ELKInputTextFieldEmali) {
//        return YES;
//    } else if (self.textFieldType == ELKInputTextFieldVaildCode) {
//        NSInteger number = self.limitNumber ? self.limitNumber : 6;
//        return [self elk_isValidLimitString:kNumberString string:string] && [self elk_isValidLimitTextField:textField string:string range:range limitNumber:number];
//
//    }
//    return YES;
//}

//- (BOOL)elk_isValidLimitTextField:(UITextField *)textField string:(NSString *)string range:(NSRange)range limitNumber:(NSInteger)limitNumber {
//    if (range.length == 1 && string.length == 0) {
//        return YES;
//    } else if (textField.text.length >= limitNumber) {
//        return textField.text = [textField.text.mutableCopy substringWithRange:NSMakeRange(0, limitNumber)];
//        return YES;
//    } else {
//        return YES;
//    }
//}

/*ssa
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
