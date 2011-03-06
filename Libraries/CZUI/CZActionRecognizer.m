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
@property (nonatomic, retain, readwrite) NSDictionary *handlers;
@end

@implementation CZActionRecognizer

#pragma mark -
@synthesize handlers=_handlers;
@synthesize state=_state;
@synthesize enabled=_enabled;
@synthesize view=_view;

#pragma mark -
#pragma mark Initializers
+ (id)actionRecognizer { return [self actionRecognizerWithHandler:nil forState:CZActionRecognizerStateNull]; }
+ (id)actionRecognizerWithHandler:(CZActionHandler)handler { return [[[self alloc] initWithHandler:handler forState:CZActionRecognizerStateRecognized] autorelease]; }
+ (id)actionRecognizerWithHandler:(CZActionHandler)handler forState:(CZActionRecognizerState)theState { return [[[self alloc] initWithHandler:handler forState:theState] autorelease]; }
- (id)init {
	self = [self initWithHandler:nil forState:CZActionRecognizerStateCancelled];
	return self;
}
- (id)initWithHandler:(CZActionHandler)handler forState:(CZActionRecognizerState)theState {
	if ((self = [super init])) {
		if (handler && (theState != CZActionRecognizerStateNull)) [self addHandler:handler forState:theState];
	}
	return self;
}

#pragma mark -
#pragma mark Custom Setters
- (void)setState:(CZActionRecognizerState)aState {
	_state = aState;
	if (_state == CZActionRecognizerStateRecognized || _state == CZActionRecognizerStateChanged) {
		for (CZActionHandler handler in [self.handlers objectForKey:[NSNumber numberWithInteger:_state]]) handler(self);
		[self reset];
	}
}
- (void)setEnabled:(BOOL)isEnabled {
	_enabled = isEnabled;
	if (!_enabled) self.state = CZActionRecognizerStateCancelled;
}

#pragma mark -
#pragma mark Handler System
- (void)addHandler:(CZActionHandler)handler forState:(CZActionRecognizerState)theState {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSMutableDictionary *mutableHandlers = [NSMutableDictionary dictionaryWithDictionary:self.handlers];
	NSMutableArray *handlersForState = [NSMutableArray arrayWithArray:[mutableHandlers objectForKey:[NSNumber numberWithInteger:theState]]];
	[handlersForState addObject:[[handler copy] autorelease]];
	[mutableHandlers setObject:[NSArray arrayWithArray:handlersForState] forKey:[NSNumber numberWithInteger:theState]];
	self.handlers = [NSDictionary dictionaryWithDictionary:mutableHandlers];
	[pool release];
}

#pragma mark -
#pragma mark Subclass Methods
- (void)receivedEvent:(CZ_DYNAMIC_TYPE(NSEvent, UIEvent) *)event {
	
}
- (void)reset { self.state = CZActionRecognizerStatePossible; }

#pragma mark -
#pragma mark Memory Management
- (void)dealloc {
	[_handlers release];
	[super dealloc];
}

@end