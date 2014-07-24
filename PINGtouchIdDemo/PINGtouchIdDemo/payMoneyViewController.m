//
//  ModalViewController.m
//  Popping
//
//  Created by André Schneider on 16.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "payMoneyViewController.h"
#import "UIColor+CustomColors.h"

@interface payMoneyViewController()<UITextFieldDelegate>
@property (strong,nonatomic) UITapGestureRecognizer *tap;
@property (strong, nonatomic) UITextField *inputMoneyTextField;
@property (strong, nonatomic) UITextField *inputPassTextField;
- (void)addPayView;
- (void)addPassView;
//- (void)dismiss:(id)sender;


@end

@implementation payMoneyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:self.tap];

    
    self.view.layer.cornerRadius = 8.f;
    self.view.backgroundColor = [UIColor customGrayColor];
    if ([self.modalViewType isEqual:@0]) {
        NSLog(@"---->addPayView");
        [self addPayView];
    }else{
        NSLog(@"---->addPassView");
        [self addPassView];
    }

}


#pragma mark - Private Instance methods

-(UITextField*)inputMoneyTextField{
    if(!_inputMoneyTextField){
        _inputMoneyTextField = [[UITextField alloc] init];
    }
    return _inputMoneyTextField;
}


-(UITextField*)inputPassTextField{
    if(!_inputPassTextField){
        _inputPassTextField = [[UITextField alloc] init];
    }
    return _inputPassTextField;
}

-(NSNumber*)modalViewType{
    if (!_modalViewType) {
        _modalViewType = @0;
    }
    return _modalViewType;
}

- (void)addPassView
{
    self.inputPassTextField.delegate = self;
    self.inputPassTextField.secureTextEntry = YES ;
    self.inputPassTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.inputPassTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.inputPassTextField.tag = 10;
    self.inputPassTextField.keyboardType =  UIKeyboardTypeASCIICapable;
    self.inputPassTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.inputPassTextField.returnKeyType = UIReturnKeyDone;
    self.inputPassTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputPassTextField.borderStyle =  UITextBorderStyleNone;
    self.inputPassTextField.backgroundColor = [UIColor whiteColor];
    self.inputPassTextField.layer.cornerRadius = 8.0f;
    self.inputPassTextField.placeholder = @"输入密码" ;

    [self.view addSubview:self.inputPassTextField];
    
    
    UILabel* passTitle = [[UILabel alloc] init];
    passTitle.textAlignment = NSTextAlignmentCenter;
    passTitle.translatesAutoresizingMaskIntoConstraints = NO;
    passTitle.font = [UIFont fontWithName:@"Avenir" size:35];
    passTitle.text = @"密码";
    passTitle.textColor = [UIColor customGreenColor];
    [self.view addSubview:passTitle];
    
    UIButton *cfmPassBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cfmPassBtn.translatesAutoresizingMaskIntoConstraints = NO;
    cfmPassBtn.tintColor = [UIColor whiteColor];
    cfmPassBtn.titleLabel.font = [UIFont fontWithName:@"Avenir" size:16];
    [cfmPassBtn setTitle:@" 确定 " forState:UIControlStateNormal];
    [cfmPassBtn addTarget:self action:@selector(confirmPass:) forControlEvents:UIControlEventTouchUpInside];
    cfmPassBtn.backgroundColor = [UIColor customBlueColor];
    cfmPassBtn.layer.cornerRadius = 8.0f;
    [self.view addSubview:cfmPassBtn];
    //input field text field
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.inputPassTextField
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.inputPassTextField
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.inputPassTextField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:30]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.inputPassTextField
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:100]];
    //
    //    [self.view addConstraints:[NSLayoutConstraint
    //                               constraintsWithVisualFormat:@"V:[inputMoneyTextField]-|"
    //                               options:0
    //                               metrics:nil
    //                               views:NSDictionaryOfVariableBindings(inputMoneyTextField)]];
    //dissmissbutton
    
    //passbtn
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:cfmPassBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[cfmPassBtn]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(cfmPassBtn)]];
    
    //passtitle
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:passTitle
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-[passTitle]"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(passTitle)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:passTitle
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:40]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:passTitle
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:100]];
}


- (void)addPayView
{
    self.inputMoneyTextField.delegate = self;

    self.inputMoneyTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.inputMoneyTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.inputMoneyTextField.tag = 10;
    self.inputMoneyTextField.keyboardType = UIKeyboardTypeDecimalPad;// UIKeyboardTypeASCIICapable;
    self.inputMoneyTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.inputMoneyTextField.returnKeyType = UIReturnKeyDone;
    self.inputMoneyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputMoneyTextField.borderStyle =  UITextBorderStyleNone;
    self.inputMoneyTextField.backgroundColor = [UIColor whiteColor];
    self.inputMoneyTextField.layer.cornerRadius = 8.0f;
    self.inputMoneyTextField.placeholder = @" 输入金额" ;
    [self.view addSubview:self.inputMoneyTextField];


    UILabel* moneyTitle = [[UILabel alloc] init];
    moneyTitle.textAlignment = NSTextAlignmentCenter;
    moneyTitle.translatesAutoresizingMaskIntoConstraints = NO;
    moneyTitle.font = [UIFont fontWithName:@"Avenir" size:35];
    moneyTitle.text = @"金额";
    moneyTitle.textColor = [UIColor customGreenColor];
    [self.view addSubview:moneyTitle];
    
    UIButton *cfmMoneyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cfmMoneyBtn.translatesAutoresizingMaskIntoConstraints = NO;
    cfmMoneyBtn.tintColor = [UIColor whiteColor];
    cfmMoneyBtn.titleLabel.font = [UIFont fontWithName:@"Avenir" size:16];
    [cfmMoneyBtn setTitle:@" 确定 " forState:UIControlStateNormal];
    [cfmMoneyBtn addTarget:self action:@selector(confirmMoney:) forControlEvents:UIControlEventTouchUpInside];
    cfmMoneyBtn.backgroundColor = [UIColor customBlueColor];
    cfmMoneyBtn.layer.cornerRadius = 8.0f;
    [self.view addSubview:cfmMoneyBtn];
//input field text field
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.inputMoneyTextField
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.inputMoneyTextField
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.inputMoneyTextField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:30]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.inputMoneyTextField
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:100]];

//
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"V:[inputMoneyTextField]-|"
//                               options:0
//                               metrics:nil
//                               views:NSDictionaryOfVariableBindings(inputMoneyTextField)]];
//dissmissbutton
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:cfmMoneyBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[cfmMoneyBtn]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(cfmMoneyBtn)]];
//---> MoneyTitle
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:moneyTitle
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-[moneyTitle]"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(moneyTitle)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:moneyTitle
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:40]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:moneyTitle
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:100]];

}

- (void)confirmMoney:(id)sender
{
   
    [self dismissViewControllerAnimated:YES completion:^{
        if([self.myDelegate respondsToSelector:@selector(moneyViewControllerDismissed:)]){
            [self.myDelegate moneyViewControllerDismissed:self.inputMoneyTextField.text];
        }
    }];
    
}

- (void)confirmPass:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        if([self.myDelegate respondsToSelector:@selector(passViewControllerDismissed:)]){
            [self.myDelegate passViewControllerDismissed:self.inputPassTextField.text];
        }
    }];
    
}

//textfiled resignFirstResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touched begin");
    UITouch *touch = [[event allTouches] anyObject];
    if (([self.inputPassTextField isFirstResponder] || [self.inputMoneyTextField isFirstResponder]) && [touch view] != self.inputMoneyTextField) {
        [self.inputMoneyTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"begin edit");
    NSLog(@"frame is %f, %f", self.view.frame.origin.x, self.view.frame.origin.y);
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 40, self.view.frame.size.width, self.view.frame.size.height);
    
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEdit");
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 40, self.view.frame.size.width, self.view.frame.size.height);
}




@end
