//
//  CZObnoxiousToggleCell.m
//  CZKit
//
//  Created by Carter Allen on 12/10/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CZObnoxiousToggleCell.h"

@implementation CZObnoxiousToggleCell
/*-(void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	cellFrame.size.height = 27;
	cellFrame.size.width = 95;
	NSBezierPath *border = [NSBezierPath bezierPathWithRoundedRect:cellFrame xRadius:4.75 yRadius:4.75];
	[border setLineWidth:1.0];
	NSBezierPath *inset = [border copy];
	[[NSColor redColor] set];
	NSAffineTransform *insetTransform = [NSAffineTransform transform];
	[insetTransform translateXBy:0.0 yBy:0.75];
	[insetTransform scaleXBy:0.9 yBy:0.0];
	[inset transformUsingAffineTransform:insetTransform];
	[inset stroke];
	[inset release];
	[[NSColor colorWithCalibratedWhite:0.246 alpha:1.000] set];
	NSGradient *backGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.47 alpha:1.000] endingColor:[NSColor colorWithCalibratedWhite:0.669 alpha:1.000]];
	[backGradient drawInBezierPath:border angle:90.0];
	NSShadow *innerShadow = [[NSShadow alloc] init];
	[border addClip];
	[border stroke];
	[innerShadow setShadowColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.80]];
	[innerShadow setShadowOffset:NSMakeSize(0.0, -0.9)];
	[innerShadow setShadowBlurRadius:2.0];
	[innerShadow set];
	NSBezierPath *largeBorder = [border copy];
	NSAffineTransform *transform = [NSAffineTransform transform];
	[transform scaleBy:2.0];
	[transform translateXBy:-5 yBy:.1];
	[largeBorder transformUsingAffineTransform:transform];
	[largeBorder stroke];
}*/
@end