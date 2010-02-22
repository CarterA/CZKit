//
//  CZDisclosureView.m
//  CZKit
//
//  Created by Carter Allen on 2/9/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "CZDisclosureView.h"
#import "CZDisclosureViewHeader.h"

#define CZDisclosureViewDefaultHiddenHeight 20.0

@interface CZDisclosureView (Private)
- (void)removeSubviews;
- (void)restoreSubviews;
- (void)resizeWindowBy:(float)amount;
@end

@implementation CZDisclosureView
#pragma mark Properties
- (BOOL)isOpen { return isOpen; }
- (void)setIsOpen:(BOOL)value {
	if (value) [self open:nil];
	else [self close:nil];
}
@synthesize title;
#pragma mark Archiving Support
- (id)initWithCoder:(NSCoder *)coder {
	if (!(self = [super initWithCoder:coder])) return nil;
	if ([coder allowsKeyedCoding]) {
		if ([coder containsValueForKey:@"_hiddenWindowSize"]) _hiddenWindowSize = [coder decodeSizeForKey:@"_hiddenWindowSize"];
		if ([coder containsValueForKey:@"_expandedWindowSize"]) _expandedWindowSize = [coder decodeSizeForKey:@"_expandedWindowSize"];
		if ([coder containsValueForKey:@"isOpen"]) isOpen = [coder decodeBoolForKey:@"isOpen"];
		if ([coder containsValueForKey:@"title"]) title = [coder decodeObjectForKey:@"title"];
	}
	title = @"Testing";
	NSRect frame = self.bounds;
	headerView = [[CZDisclosureViewHeader alloc] initWithFrame:NSMakeRect(frame.origin.x, frame.origin.y + frame.size.height - CZDisclosureViewDefaultHiddenHeight, frame.size.width, CZDisclosureViewDefaultHiddenHeight)];
	[(CZDisclosureViewHeader *)headerView setParent:self];
	contentView = [[NSView alloc] initWithFrame:NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - headerView.frame.size.height)];
	[contentView setAutoresizingMask:[self autoresizingMask]];
	[self addSubview:contentView];
	[self addSubview:headerView];
	[self setNeedsDisplay:YES];
	return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
	[super encodeWithCoder:coder];
	if ([coder allowsKeyedCoding]) {
		[coder encodeSize:_hiddenWindowSize forKey:@"_hiddenWindowSize"];
		[coder encodeSize:_expandedWindowSize forKey:@"_expandedWindowSize"];
		[coder encodeBool:isOpen forKey:@"isOpen"];
	}
}
#pragma mark General
- (BOOL)acceptsFirstResponder { return NO; }
- (void)dealloc {
	if (hiddenSubviews) [hiddenSubviews release];
	[super dealloc];
}
- (id)initWithFrame:(NSRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
	isOpen = YES;
    _hiddenWindowSize = self.window.frame.size;
    return self;
}
#pragma mark Actions
- (IBAction)toggle:(id)sender { [self setIsOpen:!isOpen]; }
- (IBAction)open:(id)sender {
	if (isOpen) return;
	[self restoreSubviews];
	NSSize hiddenSize = self.frame.size;
	[self setFrameSize:NSMakeSize(hiddenSize.width, _expandedViewSize.height)];
	[self resizeSubviewsWithOldSize:_expandedViewSize];
	[self setFrameSize:hiddenSize];
	[self resizeWindowBy:(_expandedViewSize.height - CZDisclosureViewDefaultHiddenHeight)];
	if (_originalNextKeyView) {
		[_lastChildKeyView setNextKeyView:[self nextKeyView]];
		[self setNextKeyView:_originalNextKeyView];
	}
	isOpen = YES;
	[self setNeedsDisplay:YES];
}
- (IBAction)close:(id)sender {
	if (!isOpen) return;
	NSView *keyLoopView = [self nextKeyView];
	if ([keyLoopView isDescendantOf:self]) {
		_originalNextKeyView = keyLoopView;
		_lastChildKeyView = keyLoopView;
		while ((keyLoopView = [_lastChildKeyView nextKeyView])) {
			if ([keyLoopView isDescendantOf:self]) _lastChildKeyView = keyLoopView;
			else break;
		}
		[self setNextKeyView:keyLoopView];
		[_lastChildKeyView setNextKeyView:nil];
	}
	else _originalNextKeyView = nil;
	_expandedViewSize = [self frame].size;
	[self resizeWindowBy:-(_expandedViewSize.height - CZDisclosureViewDefaultHiddenHeight)];
	[self removeSubviews];
	[self setNeedsDisplay:YES];
	isOpen = NO;
}
@end
#pragma mark Private Methods
@implementation CZDisclosureView (Private)
- (void)removeSubviews {
    hiddenSubviews = [[NSArray alloc] initWithArray:[contentView subviews]];
    unsigned int subviewIndex = [hiddenSubviews count];
    while (subviewIndex--) [[hiddenSubviews objectAtIndex:subviewIndex] removeFromSuperview];
}
- (void)restoreSubviews {
    unsigned int subviewIndex = [hiddenSubviews count];
    while (subviewIndex--) [contentView addSubview:[hiddenSubviews objectAtIndex:subviewIndex]];
	[hiddenSubviews release];
	hiddenSubviews = nil;
}
- (void)resizeWindowBy:(float)amount {
	NSRect frame = [contentView frame];
	frame = NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - headerView.frame.size.height);
	NSWindow *window = [self window];
	NSArray *windowSubviews;
	windowSubviews = [[window contentView] subviews];
	NSMutableArray *windowSubviewsMasks;
	windowSubviewsMasks = [NSMutableArray arrayWithCapacity:[windowSubviews count]];
	for (int windowSubviewIndex; (unsigned int)windowSubviewIndex < [windowSubviews count]; windowSubviewIndex++) {
		NSView *subview = [windowSubviews objectAtIndex:windowSubviewIndex];
		unsigned int mask = [subview autoresizingMask];
		[windowSubviewsMasks addObject:[NSNumber numberWithUnsignedInt:mask]];
		if (subview == self) {
			mask |= NSViewHeightSizable;
            mask &= ~NSViewMaxYMargin;
            mask &= ~NSViewMinYMargin;
		}
		else if (NSMaxY([subview frame]) < NSMaxY(frame)) {
            mask &= ~NSViewHeightSizable;
            mask |= NSViewMaxYMargin;
            mask &= ~NSViewMinYMargin;
		}
		else {
			mask &= ~NSViewHeightSizable;
			mask &= ~NSViewMaxYMargin;
			mask |= NSViewMinYMargin;
		}
		[subview setAutoresizingMask:mask];
	}
	NSMutableArray *subviewMasks = [NSMutableArray arrayWithCapacity:[[contentView subviews] count]];
	for (int subviewIndex; (unsigned int)subviewIndex < [[contentView subviews] count]; subviewIndex++) {
        NSView *subview = [[contentView subviews] objectAtIndex:subviewIndex];
        unsigned int mask = [subview autoresizingMask];
        [subviewMasks addObject:[NSNumber numberWithUnsignedInt:mask]];
        mask &= ~NSViewHeightSizable;
        mask &= ~NSViewMaxYMargin;
        mask |= NSViewMinYMargin;
        [subview setAutoresizingMask:mask];
    }
	NSRect newWindowFrame = [window frame];
	newWindowFrame.origin.y -= amount;
	newWindowFrame.size.height += amount;
	if ([window isVisible]) [window setFrame:newWindowFrame display:YES animate:YES];
    else [window setFrame:newWindowFrame display:NO];
	NSSize newWindowMinOrMaxSize = [window minSize];
    newWindowMinOrMaxSize.height += amount;
    [window setMinSize:newWindowMinOrMaxSize];
	newWindowMinOrMaxSize = [window maxSize];
	if (newWindowMinOrMaxSize.height > 0) {
        newWindowMinOrMaxSize.height += amount;
        [window setMaxSize:newWindowMinOrMaxSize];
    }
	for (unsigned int theIndex; theIndex < [windowSubviewsMasks count]; theIndex++) [(NSView *)[windowSubviews objectAtIndex:theIndex] setAutoresizingMask:[[windowSubviewsMasks objectAtIndex:theIndex] unsignedIntValue]];
	for (unsigned int theIndex; theIndex < [subviewMasks count]; theIndex++) [(NSView *)[[contentView subviews] objectAtIndex:theIndex] setAutoresizingMask:[[subviewMasks objectAtIndex:theIndex] unsignedIntValue]];
}
@end