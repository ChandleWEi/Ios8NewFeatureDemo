//
//  logInViewController.h
//  PINGtouchIdDemo
//
//  Created by ChandlerWEi on 6/13/14.
//  Copyright (c) 2014 chandlewei. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "MyHomeViewController.h"
#import "GloableImageKeys.h"
#import "MBProgressHUD.h"
#import "UIColor+CustomColors.h"
#import <LocalAuthentication/LocalAuthentication.h>

#define dTagProgressHUD    3000

#define sizeOfLogoImage                          self.view.frame.size.height*0.3  //全局位置
#define userNameTextFieldOriginY          self.view.frame.size.height*0.35
#define logInBtnOriginY                             self.view.frame.size.height*0.58
#define signUpBtnOriginY                          self.view.frame.size.height*0.9


#define TagWithLogoImage       100
#define TagWithUserName        101
#define TagWithPassword         102
#define TagWithLogIn                101
#define TagWithSignUp              102

#define wordWithLogInBtn            @"Log In"
#define wordWithSignUpBtn         @"Sign Up"

#define defaultWordWithUserName            @"UserName"
#define defaultWordWithPassword             @"Password"

#define dAnimationDurationViewPop               0.3  //动画时间

#define imageOfLogoImage [UIImage imageNamed:@"yqb"]//   logo 图片名称



@interface LoginViewController ()<UITextFieldDelegate,NSURLConnectionDelegate>

@property (assign, nonatomic) CGRect viewInitialPosition;
@property (strong, nonatomic) NSNumber* passcodeFlag;
@property (strong,nonatomic) UITextField * userNameTextField;
@end

@implementation LoginViewController
@synthesize  viewInitialPosition = _viewInitialPosition;
@synthesize Defaults;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor backgroundColor];
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden =YES;
    if ([self.passcodeFlag boolValue]) {
        if([self canEvaluatePolicy]){
            if ([self evaluatePolicy]) {
                 [self performSegueWithIdentifier:@"login" sender:nil];
            }
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _viewInitialPosition = self.view.bounds;
    self.view.backgroundColor= [UIColor backgroundColor];


    //隐藏键盘
    UIButton *allViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allViewBtn.backgroundColor =[UIColor clearColor];
    allViewBtn.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    [allViewBtn addTarget:self action:@selector(hideKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:allViewBtn];

    UIImageView * logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, sizeOfLogoImage)];
    logoImage.image = imageOfLogoImage;
    logoImage.backgroundColor= [UIColor backgroundColor];
    logoImage.tag = TagWithLogoImage;
    [self.view addSubview:logoImage];

    

    UIImageView *textFieldBg=[[UIImageView alloc]initWithFrame:CGRectMake(0, userNameTextFieldOriginY, 320, 90)];
    textFieldBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFieldBg];
    self.userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, userNameTextFieldOriginY, 290,45)];
    self.userNameTextField.delegate = self;


    self.userNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.userNameTextField.tag = TagWithUserName;
    self.userNameTextField.borderStyle = UITextBorderStyleLine;
    
    
    
    
    self.userNameTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.userNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.userNameTextField.returnKeyType = UIReturnKeyNext;
    self.userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameTextField.borderStyle = UITextBorderStyleNone;
    self.userNameTextField.placeholder = defaultWordWithUserName ;
    self.userNameTextField.backgroundColor = [UIColor whiteColor];
    

    
    CALayer *TopBorder = [CALayer layer];
    TopBorder.frame = CGRectMake(0.0f, userNameTextFieldOriginY-1, self.view.frame.size.width, 1.0f);
    TopBorder.backgroundColor = [UIColor customGrayColor].CGColor;
    [self.view.layer addSublayer:TopBorder];
    
    CALayer *MidBorder = [CALayer layer];
    MidBorder.frame = CGRectMake(30.0f, userNameTextFieldOriginY+45, self.view.frame.size.width, 1.0f);
    MidBorder.backgroundColor = [UIColor customGrayColor].CGColor;
    [self.view.layer addSublayer:MidBorder];

    CALayer *BottomBorder = [CALayer layer];
    BottomBorder.frame = CGRectMake(0.0f, userNameTextFieldOriginY+91, self.view.frame.size.width, 1.0f);
    BottomBorder.backgroundColor = [UIColor customGrayColor].CGColor;
    [self.view.layer addSublayer:BottomBorder];
//
//    userNameTextField.clipsToBounds = YES;
//    userNameTextField.layer.borderColor=[[UIColor customGrayColor]CGColor];
//    userNameTextField.layer.borderWidth= 1.0f;
//    CALayer *rightBorder = [CALayer layer];
//    rightBorder.borderColor = [UIColor whiteColor].CGColor;
//    rightBorder.borderWidth = 2;
//    rightBorder.frame = CGRectMake(0, 0, CGRectGetWidth(userNameTextField.frame), CGRectGetHeight(userNameTextField.frame)+2);
//
//    [userNameTextField.layer addSublayer:rightBorder];
//    
    
//    CAShapeLayer *line = [CAShapeLayer layer];
//    UIBezierPath *linePath=[UIBezierPath bezierPath];
//    [linePath moveToPoint: CGPointMake(30, userNameTextFieldOriginY + 44)];
//    [linePath addLineToPoint:CGPointMake(320, userNameTextFieldOriginY + 44)];
//    line.path=linePath.CGPath;
//    line.fillColor = [UIColor redColor].CGColor;
//    line.borderWidth = 1.0f;
//    line.opacity = 1.0;
//    line.strokeColor = [UIColor redColor].CGColor;
//    [userNameTextField.layer addSublayer:line];
    //    userNameTextField.layer.cornerRadius=8.0f;
    


     [self.view addSubview:self.userNameTextField];


    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, userNameTextFieldOriginY+46, 260,45)];
    passwordTextField.delegate = self;
    passwordTextField.tag = TagWithPassword;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.placeholder = defaultWordWithPassword;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordTextField];

    
    UIButton * logInBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logInBtn.frame = CGRectMake(25,logInBtnOriginY-20, 270, 45);
    logInBtn.tag = TagWithLogIn;
    [logInBtn setBackgroundImage:navigationImage5 forState:UIControlStateNormal];
    logInBtn.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    [logInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logInBtn setTitle:wordWithLogInBtn forState:UIControlStateNormal];
    [logInBtn addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
    [logInBtn setBackgroundColor:[UIColor customGreenColor]];
        logInBtn.layer.cornerRadius=8.0f;
//        logInBtn.layer.borderColor=[[UIColor grayColor]CGColor];
        logInBtn.layer.borderWidth= 0.4f;
    [self.view addSubview:logInBtn];




    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
	// Do any additional setup after loading the view.
    
    
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//     self.navigationController.navigationBar.hidden =YES;
//}
//登陆
-(void)logIn:(id)sender
{
    [self performSegueWithIdentifier:@"login" sender:nil];
    NSLog(@"登陆");
    [self hideKeyboard:nil];

        
    UITextField * username = (UITextField*)[self.view viewWithTag:TagWithUserName];
    UITextField * password = (UITextField*)[self.view viewWithTag:TagWithPassword];
    
    if(username.text.length<=0||password.text.length<=0)
    {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Tips" message:@"UserName or Password is Null" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
    }else{

        MBProgressHUD * HUD= [[MBProgressHUD alloc] initWithView:self.view];
        HUD.labelText = @"登录中...";
        HUD.tag =dTagProgressHUD;
        [self.view addSubview:HUD];
        [HUD show:YES];

      
        
    }

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}
#pragma mark ------监视键盘动作
//点击背景 键盘消失
-(void)hideKeyboard:(id)sender
{
    UITextField *userName = (UITextField *)[self.view viewWithTag:TagWithUserName];
    UITextField *password = (UITextField *)[self.view viewWithTag:TagWithPassword];
    [userName resignFirstResponder];
    [password resignFirstResponder];
}

//键盘隐藏
-(void)keyboardDidHide:(NSNotification*)notification
{
    [UIView animateWithDuration:dAnimationDurationViewPop animations:^{
        self.view.frame =_viewInitialPosition; //返回初始状态
    }];
}
//出现键盘
-(void)keyboardDidShow:(NSNotification *)notification
{
       id userInfo=notification.userInfo;
    NSValue* keyboard=[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat height=[keyboard CGRectValue].size.height;


    UITextField *password = (UITextField *)[self.view viewWithTag:TagWithPassword];
//
    CGFloat passwordOriginY = password.frame.origin.y;

    CGFloat viewSizeHeight = self.view.frame.size.height;

    if ((viewSizeHeight-(passwordOriginY+45))< height) {
        CGFloat viewY = height -(viewSizeHeight-(passwordOriginY +55));
        [UIView animateWithDuration:dAnimationDurationViewPop animations:^{
            self.view.frame = CGRectMake(0, -viewY, 320, _viewInitialPosition.size.height);
        }];

    }
}

#pragma mark ------ textFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    UITextField *userName = (UITextField *)[self.view viewWithTag:TagWithUserName];
    UITextField *password = (UITextField *)[self.view viewWithTag:TagWithPassword];
   
    if (textField.tag == TagWithUserName) {
        if ([userName.text length]>0) {
            [password becomeFirstResponder];
            return YES;
        } else {
            return NO;
        }
    }else if(textField.tag == TagWithPassword){
        if ([password.text length]>0) {
            [password resignFirstResponder];
            [userName resignFirstResponder];
            [self logIn:nil];
            return YES;
        } else {
            return NO;
        }
    }else {
        return NO;
    }
}

- (BOOL)canEvaluatePolicy
{
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    BOOL success;
    success = [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (success) {
        return true;
        
    } else {
        return false;
    }
    
}

-(NSNumber*)passcodeFlag{
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"fingerSwitch"]){
        _passcodeFlag = [[NSUserDefaults standardUserDefaults] objectForKey:@"fingerSwitch"];
    }else{
        _passcodeFlag = @0;
    }
    
    return _passcodeFlag;
}

- (BOOL)evaluatePolicy
{
    NSLog(@"--->0");
    LAContext *context = [[LAContext alloc] init];
    __block  NSString *msg;
    __block BOOL result;
    __block NSInteger touchIdStatus;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    // show the authentication UI with our reason string
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"UNLOCK_ACCESS_TO_LOCKED_FATURE", nil) reply:
     ^(BOOL success, NSError *authenticationError) {
         NSLog(@"--->1");
         if (success) {
             msg =[NSString stringWithFormat:NSLocalizedString(@"EVALUATE_POLICY_SUCCESS", nil)];
             result = true;
             
         } else {
             
             
             msg = [NSString stringWithFormat:NSLocalizedString(@"EVALUATE_POLICY_WITH_ERROR", nil), authenticationError.localizedDescription];
             touchIdStatus = authenticationError.code;
             
             
             result = false;
             
         }
         
         dispatch_semaphore_signal(semaphore);
         // [self printResult:self.textView message:msg];
     }];
    
    
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    if (touchIdStatus == kLAErrorUserFallback) {
        [self.userNameTextField becomeFirstResponder];
       // [self passcodeFallback];
    } else if (touchIdStatus == kLAErrorUserCancel) {
        [self.userNameTextField becomeFirstResponder];
       // [self cancelLogin:msg];
    } else {
       // [self reportError:msg];
    }
    NSLog(@"waiting result is %d", result);
    return  result;
    
    
}

@end
