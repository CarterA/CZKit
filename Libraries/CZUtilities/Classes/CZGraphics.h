//
//  CZGraphics.h
//  CZKit
//
//  Created by Carter Allen on 3/31/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

@interface CZGraphics : NSObject {}
@end

#define cz_NSLogCGRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#ifndef CZ_NAMESPACE_PARANOIA
#define NSLogCGRect(rect) cz_NSLogCGRect(rect)
#endif

#define cz_NSStringFromCGRect(rect) [NSString stringWithFormat:@"%s x:%.4f, y:%.4f, w:%.4f, h%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height]
#ifndef CZ_NAMESPACE_PARANOIA
#define NSStringFromCGRect(rect) cz_NSStringFromCGRect(rect)
#endif

#define cz_CGContextAddRoundedRect(context, rect, radius) cz_CGContextAddRectWithRoundedCorners(context, rect, radius, radius, radius, radius)
void cz_CGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr);
CGPathRef cz_CGPathCreateRectangularPathWithRoundedCorners(CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr);
#ifndef CZ_NAMESPACE_PARANOIA
#define CGContextAddRoundedRect(context, rect, radius) CGContextAddRectWithRoundedCorners(context, rect, radius, radius, radius, radius)
void CGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr);
CGPathRef CGPathCreateRectangularPathWithRoundedCorners(CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brr);
#endif