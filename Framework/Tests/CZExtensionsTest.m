//
//  CZExtensionsTest.m
//  CZKit
//
//  Created by Carter Allen on 12/28/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CZExtensionsTest.h"


@implementation CZExtensionsTest
- (void)setUp {
	hashableFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Hashable" ofType:@"txt"];
	NSLog(@"%@", hashableFilePath);
}
- (void)testViewConversion {
    if (![NSBundle loadNibNamed:@"ViewConversionTestView" owner:self])
        STFail(@"Could not load ViewConversionTestView.xib\n");
	STAssertNotNil(viewConversionTestView, @"ViewConversionTestView is equal to nil.");
	NSImage *image = [[NSImage alloc] initWithContentsOfView:viewConversionTestView];
	STAssertNotNil(image, @"Image generated from ViewConversionTestView is equal to nil.");
	STAssertEquals([viewConversionTestView bounds].size, [image size], @"Image generated is a different size then source view.");
}
- (void)testStringIsEmpty {
	// Test with completely empty string
	NSString *completelyEmpty = @"";
	STAssertTrue([completelyEmpty isEmpty], @"NSString's isEmpty method is broken with a completely empty string.");
	// Test with a single whitespace character
	NSString *singleWhitespaceChar = @" ";
	STAssertTrue([singleWhitespaceChar isEmpty], @"NSString's isEmpty method is broken with a single whitespace character.");
	// Test with multiple whitespace characters
	NSString *multipleWhitespaceChars = @"    ";
	STAssertTrue([multipleWhitespaceChars isEmpty], @"NSString's isEmpty method is broken with multiple whitespace characters.");
}
- (void)testDataMD5Hashing {
	NSData *testFileData = [NSData dataWithContentsOfFile:hashableFilePath];
	NSString *hash = [testFileData MD5Hash];
	STAssertTrue([hash isEqualToString:@"08724b2343f32236e7887e2ae0514f1d"], @"NSData's MD5 Hashing method returned the wrong hash.");
}
- (void)testDataSHA1Hashing {
	NSData *testFileData = [NSData dataWithContentsOfFile:hashableFilePath];
	NSString *hash = [testFileData SHA1Hash];
	STAssertTrue([hash isEqualToString:@"5072e0c9fdcea43eb2d3d4ed0c1747ca24f89c3e"], @"NSData's SHA1 Hashing method returned the wrong hash.");
}
@end
