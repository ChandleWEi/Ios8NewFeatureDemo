//
//  CustomTransitionViewController.m
//  Popping
//
//  Created by André Schneider on 14.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//
#import "KeyChainHelper.h"
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
    [self queryKeyChainButton];
    [self addKeyChainButton];
    [self delKeyChainButton];
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


- (void)delKeyChainButton
{
    
    
    UIButton *delKeyChainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    delKeyChainBtn.translatesAutoresizingMaskIntoConstraints = NO;
    delKeyChainBtn.titleLabel.font = [UIFont fontWithName:@"Avenir" size:30];
    [delKeyChainBtn setTitle:@"删除keychain" forState:UIControlStateNormal];
    [delKeyChainBtn addTarget:self action:@selector(delKeyChain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delKeyChainBtn];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:delKeyChainBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-120-[delKeyChainBtn]"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(delKeyChainBtn)]];
}

- (void)addKeyChainButton
{
    
    
    UIButton *addKeyChainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addKeyChainBtn.translatesAutoresizingMaskIntoConstraints = NO;
    addKeyChainBtn.titleLabel.font = [UIFont fontWithName:@"Avenir" size:30];
    [addKeyChainBtn setTitle:@"添加keychain" forState:UIControlStateNormal];
    [addKeyChainBtn addTarget:self action:@selector(addKeyChain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addKeyChainBtn];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addKeyChainBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
  
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-80-[addKeyChainBtn]"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(addKeyChainBtn)]];
}

- (void)queryKeyChainButton
{
    
    
    UIButton *queryKeyChainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    queryKeyChainBtn.translatesAutoresizingMaskIntoConstraints = NO;
    queryKeyChainBtn.titleLabel.font = [UIFont fontWithName:@"Avenir" size:30];
    [queryKeyChainBtn setTitle:@"查询keychain" forState:UIControlStateNormal];
    [queryKeyChainBtn addTarget:self action:@selector(queryKeyChain:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryKeyChainBtn];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:queryKeyChainBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[queryKeyChainBtn]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(queryKeyChainBtn)]];
}

- (void)delKeyChain:(id)sender{
    NSString* msg = [self deleteItemAsync];
    [self AlertMsg:msg];
    NSLog(@"msg is %@", msg);
    
}

- (void)queryKeyChain:(id)sender{
   NSString* msg = [self copyMatchingAsync];
   [self AlertMsg:msg];
    NSLog(@"msg is %@", msg);
    
}
- (void)addKeyChain:(id)sender{
    NSString* msg =  [self addItemAsync];
    [self AlertMsg:msg];
    NSLog(@"msg is %@", msg);
    
}

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
             NSLog(@"true");
             msg =[NSString stringWithFormat:NSLocalizedString(@"EVALUATE_POLICY_SUCCESS", nil)];
             result = true;
             NSString*query = [self copyMatchingAsync];
             //[self AlertMsg:query];
             NSLog(@"query is %@", query);
             
         } else {
             
             NSLog(@"false");
             msg = [NSString stringWithFormat:NSLocalizedString(@"EVALUATE_POLICY_WITH_ERROR", nil), authenticationError.localizedDescription];
             touchIdStatus = authenticationError.code;
             
             
             result = false;
             
         }
         
         dispatch_semaphore_signal(semaphore);
         // [self printResult:self.textView message:msg];
     }];
    

    NSLog(@"touchIdStatus is %ld", (long)touchIdStatus);
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
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"cancelLogin",nil) message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"ok",nil) otherButtonTitles: nil] show];
}
-(void)reportError:(NSString*)msg{
    //TODO MORE
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"other",nil) message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"ok",nil) otherButtonTitles: nil] show];
    
}


- (NSString*)copyMatchingAsync
{
    NSLog(@"copyMatchingAsync");
    NSDictionary *query = @{
                            (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService: @"SampleService",
                            (__bridge id)kSecReturnData: @YES,
                            (__bridge id)kSecUseOperationPrompt: NSLocalizedString(@"AUTHENTICATE_TO_ACCESS_SERVICE_PASSWORD", nil)
                            };
    
    
    //    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    CFTypeRef dataTypeRef = NULL;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)(query), &dataTypeRef);
    NSData *resultData = (__bridge NSData *)dataTypeRef;
    NSString * result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    
    NSString *msg = [NSString stringWithFormat:NSLocalizedString(@"SEC_ITEM_COPY_MATCHING_STATUS", nil), [self  keychainErrorToString:status]];
    if (resultData)
        msg = [msg stringByAppendingString:[NSString stringWithFormat:NSLocalizedString(@"RESULT", nil), result]];
    NSLog(@"copyMatchingAsync msg is %@ result is %@", msg, result);
    
    return [NSString stringWithFormat:@"copyMatchingAsync msg is %@ result is %@ status is %@", msg, result, [self  keychainErrorToString:status]];
    //[self printResult:self.textView message:msg];
    //    });
}


- (NSString*)addItemAsync
{
    CFErrorRef error = NULL;
    SecAccessControlRef sacObject;
    
    // Should be the secret invalidated when passcode is removed? If not then use kSecAttrAccessibleWhenUnlocked
    sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                kSecAccessControlUserPresence, &error);
    if(sacObject == NULL || error != NULL)
    {
        NSLog(@"can't create sacObject: %@", error);
        //self.textView.text = [_textView.text stringByAppendingString:[NSString stringWithFormat:NSLocalizedString(@"SEC_ITEM_ADD_CAN_CREATE_OBJECT", nil), error]];
        return  [NSString stringWithFormat:@"can't create sacObject: %@", error];
    }
    
    // we want the operation to fail if there is an item which needs authenticaiton so we will use
    // kSecUseNoAuthenticationUI
    NSDictionary *attributes = @{
                                 (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                                 (__bridge id)kSecAttrService: @"SampleService",
                                 (__bridge id)kSecValueData: [@"I'm password" dataUsingEncoding:NSUTF8StringEncoding],
                                 (__bridge id)kSecUseNoAuthenticationUI: @YES,
                                 (__bridge id)kSecAttrAccessControl: (__bridge id)sacObject
                                 };
    
    //    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    OSStatus status =  SecItemAdd((__bridge CFDictionaryRef)attributes, nil);
    
    NSString *msg = [NSString stringWithFormat:NSLocalizedString(@"SEC_ITEM_ADD_STATUS", nil), [self  keychainErrorToString:status]];
    NSLog(@"addItemAsync msg is %@ status is %d", msg, (int)status);
    return [NSString stringWithFormat:@"addItemAsync msg is %@ status is %@", msg, [self keychainErrorToString:status]];
    // [self printResult:self.textView message:msg];
    //    });
}

-(NSString*)deleteItemAsync
{
    NSDictionary *query = @{
                            (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService: @"SampleService"
                            };
    
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)(query));
    
    NSString *msg = [NSString stringWithFormat:NSLocalizedString(@"SEC_ITEM_DELETE_STATUS", nil), [self  keychainErrorToString:status]];
    NSLog(@"deleteItemAsyncmsg is %@", msg);
    return [NSString stringWithFormat:@"del msg is %@ status is %@", msg, [self keychainErrorToString:status]];
    // [super printResult:self.textView message:msg];
    //});
}



#pragma mark - Tools

- (NSString *)keychainErrorToString: (NSInteger)error
{
    
    NSString *msg = [NSString stringWithFormat:@"%ld",(long)error];
    
    switch (error) {
        case errSecSuccess:
            msg = NSLocalizedString(@"SUCCESS", nil);
            break;
        case errSecDuplicateItem:
            msg = NSLocalizedString(@"ERROR_ITEM_ALREADY_EXISTS", nil);
            break;
        case errSecItemNotFound :
            msg = NSLocalizedString(@"ERROR_ITEM_NOT_FOUND", nil);
            break;
        case -26276: // this error will be replaced by errSecAuthFailed
            msg = NSLocalizedString(@"ERROR_ITEM_AUTHENTICATION_FAILED", nil);
            
        default:
            break;
    }
    
    return msg;
}


@end
