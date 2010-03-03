//
//  CZCustomView.m
//  CZKit
//
//  Created by Carter Allen on 2/10/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "CZCustomView.h"

@interface CZCustomView (Private)
- (void)drawTextInRect:(NSRect)rect;
@end

@interface NSColor (PrivateAdditions)
- (void)drawPixelThickLineAtPosition:(int)posInPixels withInset:(int)insetInPixels inRect:(NSRect)aRect inView:(NSView *)view horizontal:(BOOL)isHorizontal flip:(BOOL)shouldFlip;
@end

@implementation CZCustomView
- (id)initWithCoder:(id)coder {
	return [super initWithCoder:coder];
}
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}
- (void)drawRect:(NSRect)rect {
	if (self.subviews.count == 0) {
		rect = self.bounds;
		NSColor *insetColor = [NSColor colorWithCalibratedWhite:1 alpha:1.000];
		NSColor *borderColor;
		borderColor = [NSColor colorWithCalibratedWhite:0.665 alpha:1.000];
		if (self.subviews.count == 0) [[NSColor colorWithCalibratedRed:0.630 green:0.701 blue:0.838 alpha:1.000] set];
		else [[NSColor colorWithCalibratedRed:0.630 green:0.701 blue:0.838 alpha:1.000] set];
		NSRectFillUsingOperation(rect,NSCompositeSourceOver);
		NSArray *subviews = [[self superview] subviews];
		if ([subviews objectAtIndex:0] == self) {
			[insetColor drawPixelThickLineAtPosition:1 withInset:0 inRect:rect inView:self horizontal:NO flip:NO];
			[insetColor drawPixelThickLineAtPosition:1 withInset:0 inRect:rect inView:self horizontal:YES flip:YES];
			[insetColor drawPixelThickLineAtPosition:0 withInset:0 inRect:rect inView:self horizontal:YES flip:NO];
			[insetColor drawPixelThickLineAtPosition:1 withInset:0 inRect:rect inView:self horizontal:NO flip:YES];
			[borderColor drawPixelThickLineAtPosition:0 withInset:0 inRect:rect inView:self horizontal:NO flip:YES];
			[borderColor drawPixelThickLineAtPosition:0 withInset:0 inRect:rect inView:self horizontal:NO flip:NO];
			[borderColor drawPixelThickLineAtPosition:0 withInset:0 inRect:rect inView:self horizontal:YES flip:YES];
			if (rect.size.height > 16) [self drawTextInRect:rect];
		}
		else if ([subviews lastObject] == self) {
			[insetColor drawPixelThickLineAtPosition:1 withInset:0 inRect:rect inView:self horizontal:NO flip:YES];
			[insetColor drawPixelThickLineAtPosition:1 withInset:0 inRect:rect inView:self horizontal:YES flip:NO];
			[insetColor drawPixelThickLineAtPosition:0 withInset:0 inRect:rect inView:self horizontal:NO flip:NO];
			[insetColor drawPixelThickLineAtPosition:1 withInset:0 inRect:rect inView:self horizontal:YES flip:YES];
			[borderColor drawPixelThickLineAtPosition:0 withInset:0 inRect:rect inView:self horizontal:YES flip:YES];
			[borderColor drawPixelThickLineAtPosition:0 withInset:0 inRect:rect inView:self horizontal:NO flip:YES];
			[borderColor drawPixelThickLineAtPosition:0 withInset:0 inRect:rect inView:self horizontal:YES flip:NO];
			if (rect.size.height > 16) [self drawTextInRect:rect];
		}
	}
}
- (void)drawTextInRect:(NSRect)rect {
	NSString *text = @"Custom View";
	NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init] autorelease];
	[attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	[attributes setObject:[NSFont boldSystemFontOfSize:12] forKey:NSFontAttributeName];
	NSShadow *theShadow = [[[NSShadow alloc] init] autorelease];
	[theShadow setShadowOffset:NSMakeSize(0,-1)];
	[theShadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:0.4]];
	[attributes setObject:theShadow forKey:NSShadowAttributeName];
	NSMutableAttributedString *string = [[[NSMutableAttributedString alloc] initWithString:text attributes:attributes] autorelease];
	NSRect boundingRect = [string boundingRectWithSize:rect.size options:0];
	NSPoint rectCenter;
	rectCenter.x = rect.size.width / 2;
	rectCenter.y = rect.size.height / 2;
	NSPoint drawPoint = rectCenter;
	drawPoint.x -= boundingRect.size.width / 2;
	drawPoint.y -= boundingRect.size.height / 2;
	drawPoint.x = roundf(drawPoint.x);
	drawPoint.y = roundf(drawPoint.y);
	[string drawAtPoint:drawPoint];
}
- (BOOL)canEditInPersonalWindow { return YES; }
- (BOOL)ibIsContainer { return YES; }
- (BOOL)ibShouldShowContainerGuides { return YES; }
- (BOOL)ibDrawFrameWhileResizing { return YES; }
- (id)ibNearestTargetForDrag { return self; }
- (BOOL)canEditSelf { return YES; }
- (BOOL)editorHandlesCaches { return YES; }
@end

@implementation NSColor (PrivateAdditions)
- (void)drawPixelThickLineAtPosition:(int)posInPixels withInset:(int)insetInPixels inRect:(NSRect)aRect inView:(NSView *)view horizontal:(BOOL)isHorizontal flip:(BOOL)shouldFlip {
	aRect = [view convertRectToBase:aRect];
	aRect = NSIntegralRect(aRect);
	if (isHorizontal) {
		if ([view isFlipped]) aRect.origin.y -= 0.5;
		else aRect.origin.y += 0.5;
	}
	else aRect.origin.x += 0.5;
	NSSize sizeInPixels = aRect.size;
	aRect = [view convertRectFromBase:aRect];
	if (shouldFlip) {
		if (isHorizontal) posInPixels = sizeInPixels.height - posInPixels - 1;
		else posInPixels = sizeInPixels.width - posInPixels - 1;
	}
	float posInPoints = posInPixels / [[NSScreen mainScreen] userSpaceScaleFactor];
	float insetInPoints = insetInPixels / [[NSScreen mainScreen] userSpaceScaleFactor];
	float startX, startY, endX, endY;
	if (isHorizontal) {
		startX = aRect.origin.x + insetInPoints;
		startY = aRect.origin.y + posInPoints;
		endX   = aRect.origin.x + aRect.size.width - insetInPoints;
		endY   = aRect.origin.y + posInPoints;
	}
	else {
		startX = aRect.origin.x + posInPoints;
		startY = aRect.origin.y + insetInPoints;
		endX   = aRect.origin.x + posInPoints;
		endY   = aRect.origin.y + aRect.size.height - insetInPoints;
	}
	NSBezierPath *path = [NSBezierPath bezierPath];
	[path setLineWidth:0.0f];
	[path moveToPoint:NSMakePoint(startX,startY)];
	[path lineToPoint:NSMakePoint(endX,endY)];
	[self set];
	[path stroke];
}
@end