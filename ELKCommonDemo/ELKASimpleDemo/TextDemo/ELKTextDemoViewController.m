//
//  ELKTextDemoViewController.m
//  ELKCommonDemo
//
//  Created by HuangZile on 2020/6/3.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ELKTextDemoViewController.h"
#import "ELKInputTextFieldView.h"
#import <Masonry/Masonry.h>


@interface ELKTextDemoViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) ELKInputTextFieldView *textFieldView;
@property (nonatomic, strong) UIButton *judgeButton;
@property (nonatomic, strong) UIButton *cutButton;


@end

@implementation ELKTextDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"textfield demo";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupAlertView];
    // Do any additional setup after loading the view.
}

- (void)setupAlertView {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"设置创建 textField类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *phone = [UIAlertAction actionWithTitle:@"手机号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setupTextFieldViewWithType:ELKInputTextFieldPhone];
    }];
    UIAlertAction *IDCard = [UIAlertAction actionWithTitle:@"身份证号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setupTextFieldViewWithType:ELKInputTextFieldIDCard];
    }];
    UIAlertAction *bankCard = [UIAlertAction actionWithTitle:@"银行卡" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setupTextFieldViewWithType:ELKInputTextFieldBankCard];

    }];
    UIAlertAction *password = [UIAlertAction actionWithTitle:@"密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self setupTextFieldViewWithType:ELKInputTextFieldPassword];

    }];
    UIAlertAction *email = [UIAlertAction actionWithTitle:@"邮箱" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self setupTextFieldViewWithType:ELKInputTextFieldEmali];

    }];
    UIAlertAction *vaildCode = [UIAlertAction actionWithTitle:@"验证码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self setupTextFieldViewWithType:ELKInputTextFieldVaildCode];

    }];
    UIAlertAction * text = [UIAlertAction actionWithTitle:@"文本" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setupTextFieldViewWithType:ELKInputTextFieldText];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
    }];
    [controller addAction:phone];
    [controller addAction:IDCard];
    [controller addAction:bankCard];
    [controller addAction:password];
    [controller addAction:email];
    [controller addAction:vaildCode];
    [controller addAction:text];

    [controller addAction:cancelAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)setupTextFieldViewWithType:(ELKInputTextFieldType )type {
    self.textFieldView = [[ELKInputTextFieldView alloc] initWithFrame:CGRectMake(0, 0, 200, 40) textFieldType:type];
    if (type == ELKInputTextFieldPassword) {
        self.textFieldView.contentType = ELKInputTextFieldLetter | ELKInputTextFieldSpot | ELKInputTextFieldNumber;
    }
    self.textFieldView.limitNumber = 8;
    [self.textFieldView.textField  becomeFirstResponder];
//    self.textFieldView.textField.delegate = self;
    [self.view addSubview:self.textFieldView];
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(200, 40)]);
    }];
    
    self.judgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.judgeButton setTitle:@"校验" forState:UIControlStateNormal];
    [self.judgeButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.judgeButton];
    [self.judgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(80, 40)]);
        make.top.equalTo(self.textFieldView.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.view);
    }];
    [self.judgeButton addTarget:self action:@selector(handleJuedge) forControlEvents:UIControlEventTouchUpInside];
    
    self.cutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cutButton setTitle:@"切换" forState:UIControlStateNormal];
    [self.cutButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.cutButton];
    [self.cutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(80, 40)]);
        make.bottom.equalTo(self.textFieldView.mas_top).with.offset(-20);
        make.centerX.equalTo(self.view);
    }];
    [self.cutButton addTarget:self action:@selector(handleCutTextField) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleCutTextField {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"修改 textField类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) _self = self;
    UIAlertAction *phone = [UIAlertAction actionWithTitle:@"手机号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _self.textFieldView.textFieldType = ELKInputTextFieldPhone;
//        [self setupTextFieldViewWithType:ELKInputTextFieldPhone];
    }];
    UIAlertAction *IDCard = [UIAlertAction actionWithTitle:@"身份证号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _self.textFieldView.textFieldType = ELKInputTextFieldIDCard;

//        [self setupTextFieldViewWithType:ELKInputTextFieldIDCard];
    }];
    UIAlertAction *bankCard = [UIAlertAction actionWithTitle:@"银行卡" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _self.textFieldView.textFieldType = ELKInputTextFieldBankCard;

//        [self setupTextFieldViewWithType:ELKInputTextFieldBankCard];

    }];
    UIAlertAction *password = [UIAlertAction actionWithTitle:@"密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _self.textFieldView.textFieldType = ELKInputTextFieldPassword;

//           [self setupTextFieldViewWithType:ELKInputTextFieldPassword];

       }];
    UIAlertAction *email = [UIAlertAction actionWithTitle:@"邮箱" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _self.textFieldView.textFieldType = ELKInputTextFieldEmali;

//           [self setupTextFieldViewWithType:ELKInputTextFieldEmali];

       }];
    UIAlertAction *vaildCode = [UIAlertAction actionWithTitle:@"验证码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _self.textFieldView.textFieldType = ELKInputTextFieldVaildCode;

//           [self setupTextFieldViewWithType:ELKInputTextFieldVaildCode];

       }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
    }];
    [controller addAction:phone];
    [controller addAction:IDCard];
    [controller addAction:bankCard];
    [controller addAction:password];
    [controller addAction:email];
    [controller addAction:vaildCode];

    [controller addAction:cancelAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)handleJuedge {
    BOOL isEmpty = [self.textFieldView elk_isContentEmpty];
    BOOL isValid = [self.textFieldView elk_isContentTextFieldValid];
    NSString *message = isValid ? @"是合法的" : @"不是合法的";

    if (isEmpty) {
        message = @"文本为空";
    }
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"12");
    return YES;
}


@end
