//
//  CZGraphics.h
//  CZKit
//
//  Created by Carter Allen on 3/31/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CZGraphics : NSObject {}
@end

void CZGraphicsCGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat radius);
void CZGraphicsCGContextAddRectWithRoundedCorners(CGContextRef context, CGRect rect, CGFloat tlr, CGFloat trr, CGFloat blr, CGFloat brl);