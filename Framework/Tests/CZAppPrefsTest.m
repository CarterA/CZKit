//
//  CZAppPrefsTest.m
//  CZKit
//
//  Created by Carter Allen on 12/28/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CZAppPrefsTest.h"

@implementation CZAppPrefsTest
- (void)setUp {
	appPrefs = [CZAppPrefs prefsForBundleID:@"com.apple.finder"];
	nonExistentAppPrefs = [CZAppPrefs prefsForBundleID:@"com.undefined.undefined"];
}
- (void)tearDown {
	appPrefs = nil;
	nonExistentAppPrefs = nil;
}
- (void)testBools {
	// Test basic Boolean Setting
	[appPrefs setBool:NO forKey:@"czBoolTest"];
	// Test basic Boolean reading
	BOOL boolTestValue = [appPrefs boolForKey:@"czBoolTest" response:&response];
	STAssertFalse((response != CZAppPrefsSuccessful), [NSString stringWithFormat:@"CZAppPrefs failed to read the bool test key. Response type: %d", response]);
	STAssertFalse(boolTestValue, @"CZAppPrefs returned YES for czBoolTest.");
	// Test Boolean reading from a non-existent key
	BOOL noAppValue = [appPrefs boolForKey:@"undefined" response:&response];
	STAssertTrue((response == CZAppPrefsKeyNotFound), @"CZAppPrefs found a value (%@) for an undefined key.", noAppValue ? @"YES" : @"NO");
	// Test Boolean reading from a non-existent app
	BOOL undefinedValue = [nonExistentAppPrefs boolForKey:@"undefined" response:&response];
	STAssertTrue((response == CZAppPrefsAppNotFound), @"CZAppPrefs found a value (%@) for an non-existent application.", undefinedValue ? @"YES" : @"NO");
}
- (void)testInts {
	// Test basic Integer writing
	[appPrefs setInteger:8 forKey:@"czIntTest"];
	// Test basic Integer reading
	int intTestValue = [appPrefs integerForKey:@"czIntTest" response:&response];
	STAssertFalse((response != CZAppPrefsSuccessful), [NSString stringWithFormat:@"CZAppPrefs failed to read the int test key. Response type: %d", response]);
	STAssertEquals(intTestValue, 8, @"CZAppPrefs returned the wrong number for czIntTest.");
	// Test Integer reading from a non-existent key
	int noAppValue = [appPrefs integerForKey:@"undefined" response:&response];
	STAssertTrue((response == CZAppPrefsKeyNotFound), @"CZAppPrefs found a value (%d) for an undefined key.", noAppValue);
	// Test Integer reading from a non-existent app
	int undefinedValue = [nonExistentAppPrefs integerForKey:@"undefined" response:&response];
	STAssertTrue((response == CZAppPrefsAppNotFound), @"CZAppPrefs found a value (%d) for an non-existent application.", undefinedValue);
}
- (void)testFloats {
	// Test basic Float writing
	[appPrefs setFloat:8.8f forKey:@"czFloatTest"];
	// Test basic Float reading
	float floatTestValue = [appPrefs floatForKey:@"czFloatTest" response:&response];
	STAssertFalse((response != CZAppPrefsSuccessful), [NSString stringWithFormat:@"CZAppPrefs failed to read the int test key. Response type: %d", response]);
	STAssertEquals(floatTestValue, 8.8f, @"CZAppPrefs returned the wrong number for czFloatTest. %f");
	// Test Float reading from a non-existent key
	float noAppValue = [appPrefs floatForKey:@"undefined" response:&response];
	STAssertTrue((response == CZAppPrefsKeyNotFound), @"CZAppPrefs found a value (%f) for an undefined key.", noAppValue);
	// Test Float reading from a non-existent app
	float undefinedValue = [nonExistentAppPrefs floatForKey:@"undefined" response:&response];
	STAssertTrue((response == CZAppPrefsAppNotFound), @"CZAppPrefs found a value (%f) for an non-existent application.", undefinedValue);
}
- (void)testDoubles {
	// Test basic Double writing
	[appPrefs setDouble:(double)8.8 forKey:@"czDoubleTest"];
	// Test basic Double reading
	double doubleTestValue = [appPrefs doubleForKey:@"czDoubleTest" response:&response];
	STAssertFalse((response != CZAppPrefsSuccessful), [NSString stringWithFormat:@"CZAppPrefs failed to read the double test key. Response type: %d", response]);
	STAssertEquals((float)doubleTestValue, 8.8f, @"CZAppPrefs returned the wrong number for czDoubleTest. %f", doubleTestValue);
	// Test Double reading from a non-existent key
	double noAppValue = [appPrefs doubleForKey:@"undefined" response:&response];
	STAssertTrue((response == CZAppPrefsKeyNotFound), @"CZAppPrefs found a value (%f) for an undefined key.", noAppValue);
	// Test Double reading from a non-existent app
	double undefinedValue = [nonExistentAppPrefs doubleForKey:@"undefined" response:&response];
	STAssertTrue((response == CZAppPrefsAppNotFound), @"CZAppPrefs found a value (%f) for an non-existent application.", undefinedValue);
}
- (void)testObjects {
	[appPrefs setObject:@"objectTestValue" forKey:@"czObjectTest"];
	// Test basic Object reading
	NSString *objectTestValue = [appPrefs objectForKey:@"czObjectTest" response:&response];
	STAssertTrue([objectTestValue isEqualToString:@"objectTestValue"], @"CZAppPrefs returned the wrong value for czObjectTest. Response: %d", response);
}
@end