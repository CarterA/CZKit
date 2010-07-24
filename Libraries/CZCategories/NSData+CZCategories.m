//
//  NSData+CZCategories.m
//  CZKit
//
//  Created by Carter Allen on 1/18/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

#import "NSData+CZCategories.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (CZCategories)
#pragma mark Hash Support
- (NSString *)cz_MD5Hash {
	const char *toBeHashed_str = [self bytes];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(toBeHashed_str, (CC_LONG)[self length], result);
	NSMutableString *hash = [NSMutableString string];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) [hash appendFormat:@"%02x", result[i]];
	return hash;
}
#ifndef CZ_NAMESPACE_PARANOIA
- (NSString *)MD5Hash { return [self cz_MD5Hash]; }
#endif
- (NSString *)cz_SHA1Hash {
	const char *toBeHashed_str = [self bytes];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(toBeHashed_str, (CC_LONG)[self length], result);
	NSMutableString *hash = [NSMutableString string];
	for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) [hash appendFormat:@"%02x", result[i]];
	return hash;
}
#ifndef CZ_NAMESPACE_PARANOIA
- (NSString *)SHA1Hash { return [self cz_SHA1Hash]; }
#endif
@end