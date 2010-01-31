//
//  NSData+CZExtensions.h
//  CZKit
//
//  Created by Carter Allen on 1/18/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

/** Adds methods for calculating an MD5 and SHA1 hash based on an NSData object.￼

The two hashing methods utilize the CommandCrypto library, which is already loaded in Foundation.
 Because of this, you can calculate hashes without linking to libcrypto or libopenssl.

*/

#import <Foundation/Foundation.h>

@interface NSData (CZExtensions)
#pragma mark Hash Support
/** Calculates and returns an MD5 hash ￼for the NSData object.

This method uses the CommonCrypto MD5() function to generate a hash based on the bytes of the NSData
 object. If you create the NSData object from a file, the resulting hash will match the result of
 running the md5 program on the original file.

@return An NSString containing a hash representing the NSData object's bytes. 
*/
- (NSString *)MD5Hash;
/** Calculates and returns an SHA1 hash ￼for the NSData object.
 
 This method uses the CommonCrypto SHA1() function to generate a hash based on the bytes of the NSData
 object. If you create the NSData object from a file, the resulting hash will match the result of
 running the openssl program on the original file.
 
 @return An NSString containing a hash representing the NSData object's bytes. 
 */
- (NSString *)SHA1Hash;
@end