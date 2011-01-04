//
//  CZActionRecognizer.m
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZActionRecognizer.h"
#import "CZActionRecognizerSubclass.h"
#import "CZView.h"

@interface CZActionRecognizer ()
@property (nonatomic, retain, readwrite) NSArray *targetActionPairs;
@property (nonatomic, retain, readwrite) NSArray *handlers;
@end

@implementation CZActionRecognizer

#pragma mark -
#pragma mark Initializers
+ (id)actionRecognizer { return [self actionRecognizerWithHandler:nil]; }
+ (id)actionRecognizerWithHandler:(CZActionHandler)handler { return [[[self alloc] initWithHandler:handler] autorelease]; }
- (id)init {
	self = [self initWithHandler:nil];
	return self;
}
- (id)initWithHandler:(CZActionHandler)handler {
	if ((self = [super init])) {
		if (handler) [self addHandler:handler];
	}
	return self;
}

#pragma mark -
#pragma mark Custom Setters
- (void)setState:(CZActionRecognizerState)value {
	state = value;
	if (state == CZActionRecognizerStateRecognized || state == CZActionRecognizerStateChanged) {
		for (CZActionHandler handler in self.handlers) handler(self);
		for (NSDictionary *pair in self.targetActionPairs) [[pair objectForKey:@"target"] performSelector:NSSelectorFromString([pair objectForKey:@"action"])];
		[self reset];
	}
}
- (void)setEnabled:(BOOL)value {
	enabled = value;
	if (!enabled) self.state = CZActionRecognizerStateCancelled;
}

#pragma mark -
#pragma mark Handler System
- (void)addHandler:(CZActionHandler)handler {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSMutableArray *mutableHandlers = [NSMutableArray arrayWithArray:self.handlers];
	[mutableHandlers addObject:[[handler copy] autorelease]];
	self.handlers = [NSArray arrayWithArray:mutableHandlers];
	[pool release];
}

#pragma mark -
#pragma mark Target/Action System
- (void)addTarget:(id)target action:(SEL)action {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSMutableArray *mutablePairs = [NSMutableArray arrayWithArray:self.targetActionPairs];
	[mutablePairs addObject:[NSDictionary dictionaryWithObjectsAndKeys:target, @"target", NSStringFromSelector(action), @"action", nil]];
	self.targetActionPairs = [NSArray arrayWithArray:mutablePairs];
	[pool release];
}
- (void)removeTarget:(id)target action:(SEL)action {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSMutableArray *mutablePairs = [NSMutableArray arrayWithArray:self.targetActionPairs];
	for (NSDictionary *pair in mutablePairs) {
		BOOL targetMatches = NO;
		BOOL actionMatches = NO;
		if ([pair objectForKey:@"target"] == target || target == nil) targetMatches = YES;
		if ([[pair objectForKey:@"action"] isEqualToString:NSStringFromSelector(action)] || action == nil) actionMatches = YES;
		if (targetMatches && actionMatches) [mutablePairs removeObject:pair];
	}
	self.targetActionPairs = [NSArray arrayWithArray:mutablePairs];
	[pool release];
}

#pragma mark -
#pragma mark Subclass Methods
- (void)receivedEvent:(NSEvent *)event {
	
}
- (void)reset { self.state = CZActionRecognizerStatePossible; }

#pragma mark -
#pragma mark Memory Management
- (void)dealloc {
	[self.targetActionPairs release];
	[self.handlers release];
	[super dealloc];
}

@end