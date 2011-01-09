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
- (void)receivedEvent:(NSEvent *)event {
	if (!self.events) self.events = [NSMutableArray array];
	[self.events addObject:event];
	if (event.type == NSLeftMouseUp) {
		// Come, sit a spell and I'll tell you story of why I use the clickCount
		// method here, instead of "rolling-my-own", as you might expect, considering
		// this system is trying to be fairly independent of the event system.
		// See, what I didn't realize at first was that the speed required for a
		// double click to be recognized by the system is actually configurable. Go
		// ahead, check it out. You can slow it down. And see, the only way to find
		// out the amount of time that it is set to is via a Carbon function called
		// GetDblTime(); And yeah, I could use that. I would have to figure out what
		// distance between points is "allowable" by the operating system. I'd also
		// just be causing unnecessary heartache considering including Carbon is just
		// going to be annoying. Sometimes it really is best to just use what is
		// proven already. And the clickCount method is.
		if ((NSUInteger)event.clickCount == self.numberOfClicksRequired) {
			self.state = CZActionRecognizerStateRecognized;
		}
	}
}
- (void)reset {
	[super reset];
	self.events = nil;
}
@end