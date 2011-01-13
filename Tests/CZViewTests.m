//
//  CZViewTests.m
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZViewTests.h"

@implementation CZViewTests
@synthesize view=_view;
- (void)setUp {
	self.view = [CZView viewWithFrame:NSZeroRect];
}
- (void)testActionRecognizerManipulation {
	CZActionRecognizer *actionRecognizer = [CZActionRecognizer actionRecognizer];
	[self.view addActionRecognizer:actionRecognizer];
	[self.view removeActionRecognizer:actionRecognizer];
}
- (void)testSingleClickActionRecognizer {
	
	// Set up a single-click action recognizer
	__block BOOL handlerWasCalled = NO;
	CZClickActionRecognizer *clickActionRecognizer = [CZClickActionRecognizer actionRecognizerWithHandler:^(CZActionRecognizer *recognizer) {
		handlerWasCalled = YES;
	}];
	[self.view addActionRecognizer:clickActionRecognizer];
	
	// Send a fake mouse click to the view
	NSEvent *downClick = [NSEvent mouseEventWithType:NSLeftMouseDown location:NSZeroPoint modifierFlags:0 timestamp:0 windowNumber:0 context:0 eventNumber:0 clickCount:0 pressure:0];
	[self.view mouseDown:downClick];
	NSEvent *upClick = [NSEvent mouseEventWithType:NSLeftMouseUp location:NSZeroPoint modifierFlags:0 timestamp:0 windowNumber:0 context:0 eventNumber:1 clickCount:1 pressure:0];
	[self.view mouseUp:upClick];
	
	// Make sure the handler was called
	STAssertTrue(handlerWasCalled, @"The single-click action recognizer handler was not called.");
	
	// Clean up
	[self.view removeActionRecognizer:clickActionRecognizer];
	
}
- (void)testDoubleClickActionRecognizer {
	
	// Set up a double-click action recognizer.
	__block BOOL handlerWasCalled = NO;
	CZClickActionRecognizer *doubleClickActionRecognizer = [CZClickActionRecognizer actionRecognizerWithHandler:^(CZActionRecognizer *recognizer) {
		handlerWasCalled = YES;
	}];
	doubleClickActionRecognizer.numberOfClicksRequired = 2;
	[self.view addActionRecognizer:doubleClickActionRecognizer];
	
	// Send two fake mouse clicks to the view.
	NSInteger i = 0;
	while (i < 2) {
		NSEvent *downClick = [NSEvent mouseEventWithType:NSLeftMouseDown location:NSZeroPoint modifierFlags:0 timestamp:0 windowNumber:0 context:0 eventNumber:0 clickCount:0 pressure:0];
		[self.view mouseDown:downClick];
		NSEvent *upClick = [NSEvent mouseEventWithType:NSLeftMouseUp location:NSZeroPoint modifierFlags:0 timestamp:0 windowNumber:0 context:0 eventNumber:0 clickCount:i+1 pressure:0];
		[self.view mouseUp:upClick];
		i++;
	}
	
	// Make sure the handler was called
	STAssertTrue(handlerWasCalled, @"The double-click action recognizer handler was not called.");
	
	// Clean up
	[self.view removeActionRecognizer:doubleClickActionRecognizer];
	
}
@end