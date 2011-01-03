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

#pragma mark Publicly Readonly Properties
@interface CZView ()
@property (nonatomic, retain) NSArray *actionRecognizers;
@end

@implementation CZView

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
- (void)mouseDown:(NSEvent *)event { [self.actionRecognizers makeObjectsPerformSelector:@selector(receivedEvent:) withObject:event]; }
- (void)mouseUp:(NSEvent *)event { [self.actionRecognizers makeObjectsPerformSelector:@selector(receivedEvent:) withObject:event]; }
- (void)mouseEntered:(NSEvent *)event { [self.actionRecognizers makeObjectsPerformSelector:@selector(receivedEvent:) withObject:event]; }
- (void)mouseExited:(NSEvent *)event { [self.actionRecognizers makeObjectsPerformSelector:@selector(receivedEvent:) withObject:event]; }

@end