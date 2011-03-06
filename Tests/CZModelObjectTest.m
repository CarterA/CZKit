//
//  CZModelObjectTest.m
//  CZKit
//
//  Created by Carter Allen on 2/9/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZModelObjectTest.h"


@implementation CZModelObjectTestRunner
@synthesize modelObject;

- (void)setUp {
	self.modelObject = [[CZModelObjectTest alloc] init];
}
- (void)tearDown {
	self.modelObject = nil;
}

- (void)testEncodingAndDecoding {
	
	// Set up test values
	id testId = @"TestId";
	NSInteger testInteger = 42;
	CGFloat testFloat = 88.0;
	NSArray *testObject = [NSArray array];
	CGRect testRect = CGRectMake(0, 0, 10, 10);
	CGSize testSize = CGSizeMake(20, 20);
	CGPoint testPoint = CGPointMake(30, 30);
	NSRange testRange = NSMakeRange(0, 40);
	
	// Assign the test values to the corresponding properties in the model object
	self.modelObject.idProperty = [testId retain];
	self.modelObject.integerProperty = testInteger;
	self.modelObject.floatProperty = testFloat;
	self.modelObject.objectProperty = testObject;
	self.modelObject.rectProperty = testRect;
	self.modelObject.sizeProperty = testSize;
	self.modelObject.pointProperty = testPoint;
	self.modelObject.rangeProperty = testRange;
	
	// Encode the object into an NSData object
	NSData *encodedModelObjectData = [NSKeyedArchiver archivedDataWithRootObject:self.modelObject];
	
	// Decode the data back into a model object
	self.modelObject = [NSKeyedUnarchiver unarchiveObjectWithData:encodedModelObjectData];
	
	// Check if all of the properties survived the trip!
	NSString *issue = @"didn't survive being encoded and decoded.";
	STAssertTrue([(NSString *)self.modelObject.idProperty isEqualToString:testId], @"modelObject.idProperty %@", issue);
	STAssertEquals(self.modelObject.integerProperty, testInteger, @"modelObject.integerProperty", issue);
	
}

@end

@implementation CZModelObjectTest
@synthesize idProperty;
@synthesize integerProperty, floatProperty;
@synthesize objectProperty;
@synthesize rectProperty, sizeProperty, pointProperty, rangeProperty;
@end
