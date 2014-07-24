//
//  KeyChainHelper.h
//  PINGtouchIdDemo
//
//  Created by ChandlerWEi on 7/14/14.
//  Copyright (c) 2014 chandlewei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonHMAC.h>

@interface KeyChainHelper : NSObject
+ (NSString*)addItemAsync;
+ (NSString*)copyMatchingAsync;
+(NSString*)deleteItemAsync;
@end
