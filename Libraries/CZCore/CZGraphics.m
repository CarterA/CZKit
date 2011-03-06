//
//  CZGraphics.m
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZGraphics.h"

NSMutableArray *CZGraphicsContextStackGetGlobal() {
	if ([NSThread currentThread] != [NSThread mainThread]) {
		NSLog(@"Attempted to use CZGraphics code on non-main thread!");
	}
	static NSMutableArray *stack;
	if (!stack) {
		stack = [[NSMutableArray alloc] init];
	}
	return stack;
}

CGContextRef CZGraphicsGetCurrentContext(void) {
	NSMutableArray *stack = CZGraphicsContextStackGetGlobal();
	if (stack.count > 0) {
		return (CGContextRef)[stack objectAtIndex:0];
	} else {
		return NULL;
	}
}

void CZGraphicsPushContext(CGContextRef context) {
	NSMutableArray *stack = CZGraphicsContextStackGetGlobal();
	[stack addObject:(id)context];
}

void CZGraphicsPopContext(void) {
	NSMutableArray *stack = CZGraphicsContextStackGetGlobal();
	[stack removeLastObject];
}

void cz_CGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr) {
	CGFloat minx = CGRectGetMinX(rect);
	CGFloat midx = CGRectGetMidX(rect);
	CGFloat maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect);
	CGFloat midy = CGRectGetMidY(rect);
	CGFloat maxy = CGRectGetMaxY(rect);
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, tlr);
	CGContextAddLineToPoint(context, minx, miny);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, trr);
	CGContextAddLineToPoint(context, maxx, miny);
	CGContextAddLineToPoint(context, maxx, midy);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, brr);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, blr);
	CGContextClosePath(context);
}
CGPathRef cz_CGPathCreateRectangularPathWithRoundedCorners(CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr) {
	CGFloat minx = CGRectGetMinX(rect);
	CGFloat midx = CGRectGetMidX(rect);
	CGFloat maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect);
	CGFloat midy = CGRectGetMidY(rect);
	CGFloat maxy = CGRectGetMaxY(rect);
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, minx, midy);
	CGPathAddArcToPoint(path, NULL, minx, miny, midx, miny, tlr);
	CGPathAddLineToPoint(path, NULL, minx, miny);
	CGPathAddArcToPoint(path, NULL, maxx, miny, maxx, midy, trr);
	CGPathAddLineToPoint(path, NULL, maxx, miny);
	CGPathAddLineToPoint(path, NULL, maxx, midy);
	CGPathAddArcToPoint(path, NULL, maxx, maxy, midx, maxy, brr);
	CGPathAddArcToPoint(path, NULL, minx, maxy, minx, midy, blr);
	CGPathCloseSubpath(path);
	CGPathRef returnPath = CGPathCreateCopy(path);
	CGPathRelease(path);
	return returnPath;
}
#ifndef CZ_NAMESPACE_PARANOIA
void CGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr) { return cz_CGContextAddRectWithRoundedCorners(context, rect, tlr, trr, brr, blr); }
CGPathRef CGPathCreateRectangularPathWithRoundedCorners(CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr) { return cz_CGPathCreateRectangularPathWithRoundedCorners(rect, tlr, trr, brr, blr); }
#endif