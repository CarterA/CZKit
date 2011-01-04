//
//  CZClickActionRecognizer.m
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZClickActionRecognizer.h"
#import "CZActionRecognizerSubclass.h"

@interface CZClickActionRecognizer ()
@property (nonatomic, retain) NSMutableArray *events;
@end

@implementation CZClickActionRecognizer
- (id)initWithHandler:(CZActionHandler)handler {
	if ((self = [super initWithHandler:handler])) {
		self.numberOfClicksRequired = 1;
	}
	return self;
}
- (void)setState:(CZActionRecognizerState)value {
	if (value == CZActionRecognizerStateRecognized) {
		self.events = nil;
	}
	[super setState:value];
}
- (void)receivedEvent:(NSEvent *)event {
	if (!self.events) self.events = [NSMutableArray array];
	[self.events addObject:event];
	if (event.type == NSLeftMouseUp) {
		NSUInteger numberOfClicks = 0;
		NSEventType lastEventType = 0;
		for (NSEvent *theEvent in self.events) {
			if ((theEvent.type == NSLeftMouseUp) && (lastEventType == NSLeftMouseDown)) numberOfClicks++;
			lastEventType = theEvent.type;
		}
		if (numberOfClicks == self.numberOfClicksRequired) {
			self.state = CZActionRecognizerStateRecognized;
		}
	}
}
@end