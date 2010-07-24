//
//  CZGraphics.h
//  CZKit
//
//  Created by Carter Allen on 3/31/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

@interface CZGraphics : NSObject {}
@end

void cz_CGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat radius);
void cz_CGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brl);
CGPathRef cz_CGPathCreateRectangularPathWithRoundedCorners(CGRect rect, CGFloat tlr, CGFloat trr, CGFloat brr, CGFloat blr);
#ifndef CZ_NAMESPACE_PARANOIA
void CGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat radius);
void CGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat brr, CGFloat blr);
CGPathRef CGPathCreateRectangularPathWithRoundedCorners(CGRect rect, CGFloat tlr, CGFloat trr, CGFloat brr, CGFloat blr);
#endif