//
//  SettingTableViewController.m
//  PINGtouchIdDemo
//
//  Created by ChandlerWEi on 6/13/14.
//  Copyright (c) 2014 chandlewei. All rights reserved.
//

#import "SettingTableViewController.h"
#import "MBProgressHUD.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "payMoneyViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "UIDevice-Hardware.h"
@interface SettingTableViewController ()<UIViewControllerTransitioningDelegate,PayDataDelegate>

@end

@implementation SettingTableViewController
@synthesize fingerSetting=_fingerSetting;
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.fingerSwitch.on = [self.fingerSetting boolValue];
//    self.navigationController.navigationBar.hidden =NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.fingerCell setSelectionStyle:UITableViewCellSelectionStyleNone];


    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeSwitch:(id)sender {
    
    
    
    UISwitch * switchSender = (UISwitch *)sender;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) {
        NSLog(@">=8.0");
        //硬件支持的
        if ([self canEvaluatePolicy]) {

            NSLog(@"change");

            self.fingerSetting =  [NSNumber numberWithBool:switchSender.on];
            if (switchSender.on){
                [self present:nil];

            }else{
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeCustomView;
                hud.labelText = @"成功关闭";
                [hud hide:YES afterDelay:2];
            }
            

        }else{
            //硬件支持的跳出设置ok页面
            NSLog(@"Device model is %@ %@ %@", [[UIDevice currentDevice] model],[[UIDevice currentDevice] hwmodel], [[UIDevice currentDevice] platform]);
            //只加了5s判断
            if([[[UIDevice currentDevice] platform] hasPrefix:@"iPhone6"]){
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeCustomView;
                hud.labelText = @"请去设置页面添加指纹";
                [hud hide:YES afterDelay:2];
                switchSender.on = false;
//                UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"设置" message:@"需要设置指纹" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
//                alert.tag = 666;
//                [alert show];
                switchSender.on = false;
                self.fingerSetting = @0;
                
            }else{
            //硬件不支持的
            NSLog(@"需要设置并判断ios硬件版本");
            if(switchSender.on){
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeCustomView;
                hud.labelText = @"硬件不支持无法开启指纹";
                [hud hide:YES afterDelay:2];
                switchSender.on = false;
                self.fingerSetting = @0;

            }
            }
        }
    }else{
        NSLog(@"<7.0");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText = @"版本过低无法开启";
        [hud hide:YES afterDelay:2];
    }
    


}

-(NSNumber*)fingerSetting{
    if (!_fingerSetting){
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"fingerSwitch"]boolValue]){
            _fingerSetting = [[NSUserDefaults standardUserDefaults] objectForKey:@"fingerSwitch"] ;
        }else{
            [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"fingerSwitch"];
            _fingerSetting = @0;
        }
    }
    return _fingerSetting;

}

-(void)setFingerSetting:(NSNumber*)fingerSetting{
    _fingerSetting = fingerSetting;
    [[NSUserDefaults standardUserDefaults] setBool:[fingerSetting boolValue] forKey:@"fingerSwitch"];
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 666 )
    {


        
        if (buttonIndex == 1 ) {
            NSLog(@"index is %ld", (long)buttonIndex);

            NSURL*url=[NSURL URLWithString:@"prefs:root=General&path=Bluetooth"];
            [[UIApplication sharedApplication] openURL:url];
            
            
        }else{
            NSLog(@"index is %ld", (long)buttonIndex);

            
        }
        
        
        
        
        
        
    }
}

- (void)present:(id)sender
{
    NSNumber * typeValue = @1;
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

-(void)passViewControllerDismissed:(NSString*)string{
    if ([string isEqualToString:@"aaa"]) {
        self.fingerSetting =  @1;
        self.fingerSwitch.on = true;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText =NSLocalizedString(@"FINGERPRINT_AUTH_OPENED",nil);// @"密码正确开启成功";
        [hud hide:YES afterDelay:2];
    }else{
        self.fingerSetting =  @0;
        self.fingerSwitch.on = false;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText =NSLocalizedString(@"FINGERPRINT_AUTH_OPEN_FAILED",nil);// @"密码错误开启失败";
        [hud hide:YES afterDelay:2];
    }

}
@end
