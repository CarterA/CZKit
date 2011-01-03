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
- (void)receivedEvent:(NSEvent *)event {
	if (!self.events) self.events = [NSMutableArray array];
	[self.events addObject:event];
	if ((event.type == NSLeftMouseUp) && (((NSEvent *)[self.events objectAtIndex:(self.events.count - 2)]).type == NSLeftMouseDown)) self.state = CZActionRecognizerStateRecognized;
}
@end