//
//  CZCategoriesTest.m
//  CZKit
//
//  Created by Carter Allen on 12/28/09.
//  Copyright 2009 Carter Allen. All rights reserved.
//

#import "CZCategoriesTest.h"


@implementation CZCategoriesTest
- (void)setUp { hashableFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Hashable" ofType:@"txt"]; }
- (void)testViewConversion {
    if (![NSBundle loadNibNamed:@"ViewConversionTestView" owner:self]) STFail(@"Could not load ViewConversionTestView.xib\n");
	STAssertNotNil(viewConversionTestView, @"ViewConversionTestView is equal to nil.");
	NSImage *image = [[NSImage alloc] cz_initWithContentsOfView:viewConversionTestView];
	STAssertNotNil(image, @"Image generated from ViewConversionTestView is equal to nil.");
	STAssertEquals([viewConversionTestView bounds].size, [image size], @"Image generated is a different size then source view.");
}
- (void)testStringIsEmpty {
	// Test with completely empty string
	NSString *completelyEmpty = @"";
	STAssertTrue([completelyEmpty cz_isEmpty], @"NSString's isEmpty method is broken with a completely empty string.");
	// Test with a single whitespace character
	NSString *singleWhitespaceChar = @" ";
	STAssertTrue([singleWhitespaceChar cz_isEmpty], @"NSString's isEmpty method is broken with a single whitespace character.");
	// Test with multiple whitespace characters
	NSString *multipleWhitespaceChars = @"    ";
	STAssertTrue([multipleWhitespaceChars cz_isEmpty], @"NSString's isEmpty method is broken with multiple whitespace characters.");
}
- (void)testDataMD5Hashing {
	NSData *testFileData = [NSData dataWithContentsOfFile:hashableFilePath];
	NSString *hash = [testFileData cz_MD5Hash];
	STAssertTrue([hash isEqualToString:@"08724b2343f32236e7887e2ae0514f1d"], @"NSData's MD5 Hashing method returned the wrong hash.");
}
- (void)testDataSHA1Hashing {
	NSData *testFileData = [NSData dataWithContentsOfFile:hashableFilePath];
	NSString *hash = [testFileData cz_SHA1Hash];
	STAssertTrue([hash isEqualToString:@"5072e0c9fdcea43eb2d3d4ed0c1747ca24f89c3e"], @"NSData's SHA1 Hashing method returned the wrong hash.");
}
- (void)testColorHexConversion {
	// Red
	NSColor *redColor = [NSColor redColor];
	NSString *hexValue = [redColor cz_hexidecimalValue];
	STAssertTrue([hexValue isEqualToString:@"ff0000"], @"NSColor's hex conversion method returned the wrong hex value for red.");
	// Green
	NSColor *greenColor = [NSColor greenColor];
	hexValue = [greenColor cz_hexidecimalValue];
	STAssertTrue([hexValue isEqualToString:@"00ff00"], @"NSColor's hex conversion method returned the wrong hex value for green.");
	// Blue
	NSColor *blueColor = [NSColor blueColor];
	hexValue = [blueColor cz_hexidecimalValue];
	STAssertTrue([hexValue isEqualToString:@"0000ff"], @"NSColor's hex conversion method returned the wrong hex value for blue.");
}
@end
