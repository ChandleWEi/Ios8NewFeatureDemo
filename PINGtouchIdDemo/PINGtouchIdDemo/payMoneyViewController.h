//
//  ModalViewController.h
//  Popping
//
//  Created by André Schneider on 16.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayDataDelegate <NSObject>

@optional
-(void)moneyViewControllerDismissed:(NSString*)string;
-(void)passViewControllerDismissed:(NSString*)string;

@end

@interface payMoneyViewController : UIViewController{
   // id _myDelegate;
}
@property(nonatomic, strong) NSNumber* modalViewType;
@property(nonatomic, assign)id<PayDataDelegate> myDelegate;


@end
