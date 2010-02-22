//
//  CZDisclosureViewHeader.m
//  CZKit
//
//  Created by Carter Allen on 2/9/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "CZDisclosureViewHeader.h"

@implementation CZDisclosureViewHeader
#pragma mark Properties
@synthesize parent;
#pragma mark General View Code
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}
- (void)drawRect:(NSRect)rect {
	if (_clicked) {
		NSGradient *background = [[NSGradient alloc] initWithStartingColor:[[NSColor colorWithCalibratedWhite:0.9 alpha:1.0] blendedColorWithFraction:0.13 ofColor:[NSColor blackColor]] endingColor:[[NSColor colorWithCalibratedWhite:0.765 alpha:1.0]blendedColorWithFraction:0.13 ofColor:[NSColor blackColor]]];
		[background drawInRect:NSMakeRect(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - 1) angle:270.0];
	}
	else {
		NSGradient *background = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.9 alpha:1.0] endingColor:[NSColor colorWithCalibratedWhite:0.765 alpha:1.0]];
		[background drawInRect:NSMakeRect(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - 1) angle:270.0];
	}
	[[NSColor darkGrayColor] set];
	NSRect strokeRect = NSInsetRect(rect, -1.0, 0.0);
	NSBezierPath *strokePath = [NSBezierPath bezierPathWithRect:strokeRect];
	[strokePath stroke];
	if (!_titleField && [parent title]) {
		_titleField = [[CZInsetTextField alloc] initWithFrame:rect];
		[_titleField setBezeled:NO];
		[_titleField setBordered:NO];
		[_titleField setDrawsBackground:NO];
		[_titleField setStringValue:[parent title]];
		[_titleField setEditable:NO];
		[_titleField setSelectable:NO];
		//[_titleField set
		[self addSubview:_titleField];
	}
}
- (void)mouseDown:(NSEvent *)theEvent {
	_clicked = YES;
	[self setNeedsDisplay:YES];
}
- (void)mouseUp:(NSEvent *)theEvent {
	_clicked = NO;
	[parent toggle:nil];
	[self setNeedsDisplay:YES];
}
@end