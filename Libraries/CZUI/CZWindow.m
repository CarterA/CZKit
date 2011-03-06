//
//  CZWindow.m
//  CZKit
//
//  Created by Carter Allen on 2/16/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZWindow.h"
#import "CZNSWindow.h"
#import "CZColor.h"

#if TARGET_OS_IPHONE
@implementation CZWindow
@end
#else

@interface CZWindow ()
@property (nonatomic, retain) NSWindow *NSWindow;
@property (nonatomic, retain) CZView *trackingView;
@end

@interface CZWindow () <NSWindowDelegate>
@end

@implementation CZWindow

@synthesize NSWindow=_NSWindow;
@synthesize trackingView=_trackingView;

- (void)dealloc {
	[_trackingView release];
	_trackingView = nil;
	[super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [CZColor whiteColor];
		self.NSWindow = [[CZNSWindow alloc] initWithCZWindow:self type:CZNSWindowTypeTitled]; 
		self.NSWindow.delegate = self;
		[[self.NSWindow contentView] setLayer:self.layer];
		[[self.NSWindow contentView] setWantsLayer:YES];
		self.layer.geometryFlipped = YES;
		self.frame = frame;
	}
	return self;
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:(CGRect) {
		.size = frame.size
	}];
	[self.NSWindow setFrame:NSRectFromCGRect(frame) display:YES animate:NO];
}

- (CGRect)frame { return NSRectToCGRect([self.NSWindow frame]); }

- (CZView *)hitTestFromEvent:(NSEvent *)event {
	CGPoint windowPoint = NSPointToCGPoint([event locationInWindow]);
	windowPoint = [self convertPoint:windowPoint fromView:nil];
	return [self hitTest:windowPoint withEvent:event];
}

- (void)sendEvent:(NSEvent *)event {
	if (event.type == NSLeftMouseDown) {
		if (![self.NSWindow isKeyWindow]) {
			[self mouseDown:event];
		}
		else {
			self.trackingView = [self hitTestFromEvent:event];
			if (self.trackingView) [self.trackingView mouseDown:event];
		}
	}
	else if (event.type == NSLeftMouseUp) {
		if (self.trackingView) [self.trackingView mouseUp:event];
		self.trackingView = nil;
	}
	else if (event.type == NSLeftMouseDragged) {
		if (self.trackingView) [self.trackingView mouseDragged:event];
	}
	else if (event.type == NSScrollWheel) {
		CZView *scrollView = [self hitTestFromEvent:event];
		[scrollView scrollWheel:event];
	}
}

- (void)mouseDown:(NSEvent *)event {
	[self makeKeyAndVisible];
}

- (void)mouseDragged:(NSEvent *)event {
	CGRect frame = self.frame;
	frame.origin.x += [event deltaX];
	frame.origin.y -= [event deltaY];
	self.frame = frame;
}

- (void)mouseUp:(NSEvent *)inEvent {}

- (void)makeKeyAndVisible {
	if (![NSApp isActive]) [NSApp activateIgnoringOtherApps:YES];
	[self.NSWindow makeKeyAndOrderFront:self];
}

@end

#endif // !TARGET_OS_IPHONE