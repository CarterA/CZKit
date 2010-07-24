//
//  CZGraphics.m
//  CZKit
//
//  Created by Carter Allen on 3/31/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

#import "CZGraphics.h"

@implementation CZGraphics
@end

void cz_CGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat radius) { cz_CGContextAddRectWithRoundedCorners(context, rect, radius, radius, radius, radius); }
void cz_CGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat brr, CGFloat blr) {
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
CGPathRef cz_CGPathCreateRectangularPathWithRoundedCorners(CGRect rect, CGFloat tlr, CGFloat trr, CGFloat brr, CGFloat blr) {
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
void CGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat radius) { return cz_CGContextAddRoundedRect(context, rect, radius); }
void CGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat brr, CGFloat blr) { return cz_CGContextAddRectWithRoundedCorners(context, rect, tlr, trr, brr, blr); }
CGPathRef CGPathCreateRectangularPathWithRoundedCorners(CGRect rect, CGFloat tlr, CGFloat trr, CGFloat brr, CGFloat blr) { return cz_CGPathCreateRectangularPathWithRoundedCorners(rect, tlr, trr, brr, blr); }
#endif