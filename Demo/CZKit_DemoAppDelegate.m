//
//  CZKit_DemoAppDelegate.m
//  CZKit Demo
//
//  Created by Carter Allen on 2/4/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import <CZKit/CZKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CZKit_DemoAppDelegate.h"

@implementation CZKit_DemoAppDelegate
@synthesize window, view;
- (void)awakeFromNib {
	
	self.view.wantsLayer = YES;
	self.view.layer.borderColor = CGColorCreateGenericGray(0.0, 1.0);
	self.view.layer.borderWidth = 1.0;
	
	CZClickActionRecognizer *clickAR = [CZClickActionRecognizer actionRecognizer];
	[clickAR addHandler:^(CZActionRecognizer *recognizer) {
		NSLog(@"Clicked.");
	} forState:CZActionRecognizerStateRecognized];
	[self.view addActionRecognizer:clickAR];
	
	CZClickActionRecognizer *doubleClickAR = [CZClickActionRecognizer actionRecognizer];
	doubleClickAR.numberOfClicksRequired = 2;
	[doubleClickAR addHandler:^(CZActionRecognizer *recognizer) {
		NSLog(@"Double clicked");
	} forState:CZActionRecognizerStateRecognized];
	[self.view addActionRecognizer:doubleClickAR];
	
}
@end