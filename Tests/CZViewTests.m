//
//  CZViewTests.m
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZViewTests.h"

@implementation CZViewTests
- (void)testActionRecognizerManipulation {
	CZView *view = [[CZView alloc] initWithFrame:NSZeroRect];
	CZActionRecognizer *actionRecognizer = [CZActionRecognizer actionRecognizer];
	[view addActionRecognizer:actionRecognizer];
	[view removeActionRecognizer:actionRecognizer];
	[view release];
}
- (void)testActionRecognizerHandlers {
	
	// Set up a view and action recognizer
	CZView *view = [[CZView alloc] initWithFrame:NSZeroRect];
	CZClickActionRecognizer *clickActionRecognizer = [CZClickActionRecognizer actionRecognizerWithHandler:^(CZActionRecognizer *recognizer) {
		NSLog(@"Clicked!");
	}];
	[view addActionRecognizer:clickActionRecognizer];
	
	// Send a fake mouse click to the view
	NSEvent *downClick = [NSEvent mouseEventWithType:NSLeftMouseDown location:NSZeroPoint modifierFlags:0 timestamp:0 windowNumber:0 context:0 eventNumber:0 clickCount:0 pressure:0];
	[view mouseDown:downClick];
	NSEvent *upClick = [NSEvent mouseEventWithType:NSLeftMouseUp location:NSZeroPoint modifierFlags:0 timestamp:0 windowNumber:0 context:0 eventNumber:0 clickCount:0 pressure:0];
	[view mouseUp:upClick];
	
	// Clean up
	[view release];
	
}
@end