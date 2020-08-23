//
//  ELKInputTextFieldView.h
//  ELKCommonDemo
//
//  Created by HuangZile on 2020/6/3.
//  Copyright © 2020 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ELKInputTextFieldType) {
    ELKInputTextFieldPhone = 0,//手机号
    ELKInputTextFieldIDCard = 1,//身份证号
    ELKInputTextFieldBankCard = 2,//银行卡号
    ELKInputTextFieldPassword = 3,//密码
    ELKInputTextFieldEmali = 4,//邮箱
    ELKInputTextFieldVaildCode = 5,//验证码
    ELKInputTextFieldText = 6,//文本输入框  只做内容长度限制

};

typedef NS_OPTIONS(NSInteger, ELKInputTextFieldContentType) {
    ELKInputTextFieldNumber = 1 << 0, //数字
    ELKInputTextFieldLetter = 1 << 1, //字母
    ELKInputTextFieldSpot = 1 << 2, //点
};


NS_ASSUME_NONNULL_BEGIN

@interface ELKInputTextFieldView : UIView

@property (nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic, assign) UIEdgeInsets contentInset;

///仅限于密码和验证码及文本输入框使用,默认密码 6 位,验证码 6位, 文本输入框 20;
@property (nonatomic, assign) NSInteger limitNumber;

///仅限于密码使用 ELKInputTextFieldPassword
@property (nonatomic, assign) ELKInputTextFieldContentType contentType;

@property (nonatomic, assign) ELKInputTextFieldType textFieldType;



- (instancetype)initWithFrame:(CGRect)frame textFieldType:(ELKInputTextFieldType)textFieldType;

///判断内容是否合法
- (BOOL)elk_isContentTextFieldValid;

///判断内容是否为空
- (BOOL)elk_isContentEmpty;

///判断内容是否可匹配
- (BOOL)elk_isContentCanMatch;


@end

NS_ASSUME_NONNULL_END
