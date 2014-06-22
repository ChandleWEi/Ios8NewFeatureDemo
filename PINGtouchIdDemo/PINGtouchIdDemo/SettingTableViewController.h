//
//  SettingTableViewController.h
//  PINGtouchIdDemo
//
//  Created by ChandlerWEi on 6/13/14.
//  Copyright (c) 2014 chandlewei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISwitch *fingerSwitch;
@property (weak, nonatomic) IBOutlet UITableViewCell *fingerCell;
@property (strong, nonatomic) NSNumber * fingerSetting;

- (IBAction)changeSwitch:(id)sender;
@end
