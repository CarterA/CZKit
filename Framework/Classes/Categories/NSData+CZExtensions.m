//
//  NSData+CZExtensions.m
//  CZKit
//
//  Created by Carter Allen on 1/18/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "NSData+CZExtensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (CZExtensions)
#pragma mark Hash Support
- (NSString *)MD5Hash {
	const char *toBeHashed_str = [self bytes];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(toBeHashed_str, (CC_LONG)[self length], result);
	NSMutableString *hash = [NSMutableString string];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) [hash appendFormat:@"%02x", result[i]];
	return hash;
}
- (NSString *)SHA1Hash {
	const char *toBeHashed_str = [self bytes];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(toBeHashed_str, (CC_LONG)[self length], result);
	NSMutableString *hash = [NSMutableString string];
	for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) [hash appendFormat:@"%02x", result[i]];
	return hash;
}
@end