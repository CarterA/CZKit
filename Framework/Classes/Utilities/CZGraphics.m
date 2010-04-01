//
//  CZGraphics.m
//  CZKit
//
//  Created by Carter Allen on 3/31/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "CZGraphics.h"

@implementation CZGraphics
@end

void CZGraphicsCGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat radius) { CZGraphicsCGContextAddRectWithRoundedCorners(context, rect, radius, radius, radius, radius); }
void CZGraphicsCGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat brr, CGFloat blr) {
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