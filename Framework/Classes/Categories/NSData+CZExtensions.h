//
//  NSData+CZExtensions.h
//  CZKit
//
//  Created by Carter Allen on 1/18/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CZExtensions)
#pragma mark Hash Support
- (NSString *)MD5Hash;
- (NSString *)SHA1Hash;
@end
