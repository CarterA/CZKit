//
//  CZGraphics.h
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZMacros.h"

CZKIT_EXTERN CGContextRef CZGraphicsGetCurrentContext(void);
CZKIT_EXTERN void CZGraphicsPushContext(CGContextRef context); // Not implemented
CZKIT_EXTERN void CZGraphicsPopContext(void); // Not implemented

#define cz_NSLogCGRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#ifndef CZ_NAMESPACE_PARANOIA
#define NSLogCGRect(rect) cz_NSLogCGRect(rect)
#endif

#define cz_NSStringFromCGRect(rect) [NSString stringWithFormat:@"%s x:%.4f, y:%.4f, w:%.4f, h%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height]
#ifndef CZ_NAMESPACE_PARANOIA
#define NSStringFromCGRect(rect) cz_NSStringFromCGRect(rect)
#endif

#define cz_CGContextAddRoundedRect(context, rect, radius) cz_CGContextAddRectWithRoundedCorners(context, rect, radius, radius, radius, radius)
CZKIT_EXTERN void cz_CGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr);
CGPathRef cz_CGPathCreateRectangularPathWithRoundedCorners(CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr);
#ifndef CZ_NAMESPACE_PARANOIA
#define CGContextAddRoundedRect(context, rect, radius) CGContextAddRectWithRoundedCorners(context, rect, radius, radius, radius, radius)
CZKIT_EXTERN void CGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr);
CZKIT_EXTERN CGPathRef CGPathCreateRectangularPathWithRoundedCorners(CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr);
#endif