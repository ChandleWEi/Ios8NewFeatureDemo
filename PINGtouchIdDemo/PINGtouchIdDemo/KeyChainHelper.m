//
//  KeyChainHelper.m
//  PINGtouchIdDemo
//
//  Created by ChandlerWEi on 7/14/14.
//  Copyright (c) 2014 chandlewei. All rights reserved.
//

#import "KeyChainHelper.h"
@implementation KeyChainHelper
+ (NSString*)copyMatchingAsync
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
        
        NSString *msg = [NSString stringWithFormat:NSLocalizedString(@"SEC_ITEM_COPY_MATCHING_STATUS", nil), [[self class ] keychainErrorToString:status]];
        if (resultData)
            msg = [msg stringByAppendingString:[NSString stringWithFormat:NSLocalizedString(@"RESULT", nil), result]];
        NSLog(@"copyMatchingAsync msg is %@ result is %@", msg, result);
    
        return [NSString stringWithFormat:@"copyMatchingAsync msg is %@ result is %@ status is %@", msg, result, [[self class] keychainErrorToString:status]];
        //[self printResult:self.textView message:msg];
//    });
}


+ (NSString*)addItemAsync
{
    CFErrorRef error = NULL;
    SecAccessControlRef sacObject;
    
    // Should be the secret invalidated when passcode is removed? If not then use kSecAttrAccessibleWhenUnlocked
    sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                kSecAttrAccessibleAlways,
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
        
        NSString *msg = [NSString stringWithFormat:NSLocalizedString(@"SEC_ITEM_ADD_STATUS", nil), [[self class] keychainErrorToString:status]];
        NSLog(@"addItemAsync msg is %@ status is %d", msg, (int)status);
    return [NSString stringWithFormat:@"addItemAsync msg is %@ status is %@", msg, [[self class] keychainErrorToString:status]];
       // [self printResult:self.textView message:msg];
//    });
}

+(NSString*)deleteItemAsync
{
    NSDictionary *query = @{
                            (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService: @"SampleService"
                            };
    
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        OSStatus status = SecItemDelete((__bridge CFDictionaryRef)(query));
        
        NSString *msg = [NSString stringWithFormat:NSLocalizedString(@"SEC_ITEM_DELETE_STATUS", nil), [[self class] keychainErrorToString:status]];
        NSLog(@"deleteItemAsyncmsg is %@", msg);
        return [NSString stringWithFormat:@"del msg is %@ status is %@", msg, [[self class] keychainErrorToString:status]];
       // [super printResult:self.textView message:msg];
    //});
}



#pragma mark - Tools

+ (NSString *)keychainErrorToString: (NSInteger)error
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

////salt_hash也是随机数
//#define SALT_HASH @"FvTivqTqZXsgLLx1v3P8TGRyVHaSOB1pvfm02wvGadj7RLHV8GrfxaZ84oGA8RsKdNRpxdAojXYg9iAj"
//+ (NSString *)securedSHA256DigestHashForPIN:(NSUInteger)pinHash
//{
//    // 1
//    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:@"test"];
//    name = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    // 2
// 
//    NSString *computedHashString = [NSString stringWithFormat:@"%@%lu%@", name, (unsigned long)pinHash, SALT_HASH];
//    // 3
//    NSString *finalHash = [self computeSHA256DigestForString:computedHashString];
//    NSLog(@"** Computed hash: %@ for SHA256 Digest: %@", computedHashString, finalHash);
//    return finalHash;
//}
//
//// This is where the rest of the magic happens.
//// Here we are taking in our string hash, placing that inside of a C Char Array, then parsing it through the SHA256 encryption method.
//+ (NSString*)computeSHA256DigestForString:(NSString*)input
//{
//    
//    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:input.length];
//    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
//    
//    // This is an iOS5-specific method.
//    // It takes in the data, how much data, and then output format, which in this case is an int array.
//    CC_SHA256(data.bytes, (unsigned int)[data length], digest);
//    
//    // Setup our Objective-C output.
//    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
//    
//    // Parse through the CC_SHA256 results (stored inside of digest[]).
//    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
//        [output appendFormat:@"%02x", digest[i]];
//    }
//    
//    return output;
//}
@end
