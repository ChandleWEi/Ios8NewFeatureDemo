//
//  CustomTransitionViewController.m
//  Popping
//
//  Created by André Schneider on 14.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "MyHomeViewController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "payMoneyViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface MyHomeViewController() <UIViewControllerTransitioningDelegate, PayDataDelegate>

@property (strong, nonatomic) NSNumber* passcodeFlag;

@end

@implementation MyHomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self addPresentButton];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}

#pragma mark - Private Instance methods

- (void)addPresentButton
{
    

    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    presentButton.translatesAutoresizingMaskIntoConstraints = NO;
    presentButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:30];
    [presentButton setTitle:@"付费" forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:presentButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:presentButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];
}

- (void)present:(id)sender
{
    NSNumber * typeValue = @0;
    payMoneyViewController *payViewController = [payMoneyViewController new];
    payViewController.transitioningDelegate = self;
    payViewController.myDelegate = self;
    if ([sender isKindOfClass:[UIButton class]]){
        NSLog(@"button click");
    }else if([sender isKindOfClass:[NSNumber class]]){
        typeValue = sender;
    }
    payViewController.modalViewType = typeValue;
    
    
    payViewController.modalPresentationStyle = UIModalPresentationCustom;

    [self presentViewController:payViewController animated:YES completion:NULL];
//    [self.navigationController presentViewController:modalViewController
//                                            animated:YES
//                                          completion:NULL];
}

-(void)moneyViewControllerDismissed:(NSString *)stringForFirst{
    NSLog(@"string is %@ %f", stringForFirst, [stringForFirst doubleValue]);
    
    //passwd 或者 指纹
    if([self.passcodeFlag boolValue]){
        if([self shouldPerformSegueWithIdentifier:@"PayResult" sender:nil]){
            [self performSegueWithIdentifier:@"PayResult" sender:nil];
        }

    }else{
        [self present:@1];
    }

}

-(void)passViewControllerDismissed:(NSString *)stringForFirst{
    NSLog(@"string is %@ %f", stringForFirst, [stringForFirst doubleValue]);
        [self performSegueWithIdentifier:@"PayResult" sender:nil];

    //[self present:@1];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        PINGcellObj *object = self.objects[indexPath.row];
//        
//        [[segue destinationViewController] setDetailItem:object];
//    }
}
//touch id trigger
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    NSLog(@"should shouldPerformSegueWithIdentifier ");
    bool triggerFlag = false;
    
    if([identifier isEqualToString:@"PayResult"]){
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) {
                    NSLog(@">=8.0");
                    if ([self canEvaluatePolicy]) {
                        triggerFlag = [self evaluatePolicy];
                   }
                }else{
                    NSLog(@"<7.0");
                    triggerFlag = false;
                }
        
    }else{
        triggerFlag = true;
    }
//    //使用自己的密码UI进行跳转
//    if([self.passcodeFlag boolValue]){
//        self.passcodeFlag = @0;
//        triggerFlag = true;
//        //使用指纹进行跳转
//    }else{
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) {
//            NSLog(@">=8.0");
//            if ([self canEvaluatePolicy]) {
//                triggerFlag = [self evaluatePolicy];
//            }
//        }else{
//            NSLog(@"<7.0");
//            triggerFlag = false;
//        }
//        //touch id check
//        
//    }
    
    return triggerFlag;
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
       [self passcodeFallback];
    } else if (touchIdStatus == kLAErrorUserCancel) {
        [self cancelLogin:msg];
    } else {
        [self reportError:msg];
    }
    NSLog(@"waiting result is %d", result);
    return  result;
    
    
}

-(void)passcodeFallback{
    
    
    [self present:@1];
    
}

-(void)AlertMsg:(NSString*)msg{
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"result",nil) message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"ok",nil) otherButtonTitles: nil] show];
}

-(void)cancelLogin:(NSString*)msg{
    //TODO MORE
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"result",nil) message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"ok",nil) otherButtonTitles: nil] show];
}
-(void)reportError:(NSString*)msg{
    //TODO MORE
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"result",nil) message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"ok",nil) otherButtonTitles: nil] show];
    
}


@end
