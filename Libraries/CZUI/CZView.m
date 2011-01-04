//
//  CZView.m
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZView.h"
#import "CZActionRecognizer.h"
#import "CZActionRecognizerSubclass.h"

#define CZ_INTERCEPT_EVENT(eventName) \
		- (void)eventName:(NSEvent *)event {\
			[self.actionRecognizers makeObjectsPerformSelector:@selector(receivedEvent:) withObject:event];\
		}

#pragma mark Publicly Readonly Properties
@interface CZView ()
@property (nonatomic, retain) NSArray *actionRecognizers;
@end

@implementation CZView

#pragma mark -
#pragma mark Initializer
+ (id)viewWithFrame:(NSRect)frame { return [[[self alloc] initWithFrame:frame] autorelease]; }

#pragma mark -
#pragma mark Action Recognizer Manipulation
- (void)addActionRecognizer:(CZActionRecognizer *)actionRecognizer {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSMutableArray *mutableActionRecognizers = [NSMutableArray arrayWithArray:self.actionRecognizers];
	[mutableActionRecognizers addObject:actionRecognizer];
	self.actionRecognizers = [NSArray arrayWithArray:mutableActionRecognizers];
	[pool release];
}
- (void)removeActionRecognizer:(CZActionRecognizer *)actionRecognizer {
	if ([self.actionRecognizers containsObject:actionRecognizer]) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		NSMutableArray *mutableActionRecognizers = [NSMutableArray arrayWithArray:self.actionRecognizers];
		[mutableActionRecognizers removeObject:actionRecognizer];
		self.actionRecognizers = [NSArray arrayWithArray:mutableActionRecognizers];
		[pool release];
	}
}

#pragma mark -
#pragma mark Event Handling for Action Recognizers
CZ_INTERCEPT_EVENT(mouseDown);
CZ_INTERCEPT_EVENT(mouseUp);
CZ_INTERCEPT_EVENT(mouseEntered);
CZ_INTERCEPT_EVENT(mouseExited);

@end