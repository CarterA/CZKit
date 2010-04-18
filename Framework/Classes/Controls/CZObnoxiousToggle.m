//
//  CZObnoxiousToggle.m
//  CZKit
//
//  Created by Carter Allen on 12/9/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CZObnoxiousToggle.h"

@implementation CZObnoxiousToggle
#pragma mark -
#pragma mark Standard NSView Methods
- (id)initWithFrame:(NSRect)frameRect {
	if ((self = [super initWithFrame:frameRect])) {
		
	}
	return self;
}
- (void)awakeFromNib {
	[self setLayer:[CALayer layer]];
	[self setWantsLayer:YES];
	[self.backgroundTrackLayer setNeedsDisplay];
	[self.layer addSublayer:self.backgroundTrackLayer];
	[self.knobLayer setNeedsDisplay];
	[self.layer insertSublayer:self.knobLayer above:self.backgroundTrackLayer];
}
#pragma mark -
#pragma mark CoreAnimation Layers
- (CALayer *)knobMaskLayer {
	if (!knobMaskLayer) {
		knobMaskLayer = [CALayer layer];
		knobMaskLayer.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
		knobMaskLayer.cornerRadius = 4.0f;
	}
	return [knobMaskLayer retain];
}
- (CAGradientLayer *)knobLayer {
	if (!knobLayer) {
		knobLayer = [CAGradientLayer layer];
		knobLayer.frame = CGRectMake(1.0f, 2.0f, self.frame.size.width / 2.5, self.frame.size.height - 3);
		//knobLayer.mask = self.knobMaskLayer;
		knobLayer.cornerRadius = 4.0f;
		knobLayer.shadowColor = CGColorCreateGenericGray(0.0f, 1.0f);
		knobLayer.shadowRadius = 2.0f;
		knobLayer.shadowOffset = CGSizeMake(0.0f, 0.0f);
		knobLayer.shadowOpacity = 50.0f;
		//knobLayer.borderColor = CGColorCreateGenericGray(0.253f, 1.000f);
		//knobLayer.borderWidth = 1.0f;
		knobLayer.geometryFlipped = YES;
		CGColorRef backgroundStart = CGColorCreateGenericGray(0.985f, 1.000f);
		CGColorRef backgroundEnd = CGColorCreateGenericGray(0.878f, 1.000f);
		knobLayer.colors = [NSArray arrayWithObjects:(id)backgroundStart, (id)backgroundEnd, nil];
		CGColorRelease(backgroundStart);
		CGColorRelease(backgroundEnd);
	}
	return [knobLayer retain];
}
- (CAGradientLayer *)backgroundTrackLayer {
	if (!backgroundTrackLayer) {
		backgroundTrackLayer = [CAGradientLayer layer];
		backgroundTrackLayer.frame = CGRectMake(0.0f, 1.0f, self.frame.size.width, self.frame.size.height - 1);
		backgroundTrackLayer.cornerRadius = 4.0f;
		backgroundTrackLayer.shadowColor = [[NSColor whiteColor] CGColor];
		backgroundTrackLayer.shadowRadius = 1.0f;
		backgroundTrackLayer.shadowOffset = CGSizeMake(0.0f, 1.0f);
		backgroundTrackLayer.shadowOpacity = 50.0f;
		backgroundTrackLayer.borderColor = CGColorCreateGenericGray(0.253, 1.000);
		backgroundTrackLayer.borderWidth = 1.0f;
		backgroundTrackLayer.geometryFlipped = YES;
		CGColorRef backgroundStart = CGColorCreateGenericGray(0.387, 1.000);
		CGColorRef backgroundMiddle = CGColorCreateGenericGray(0.496, 1.000);
		CGColorRef backgroundEnd = CGColorCreateGenericGray(0.669, 1.000);
		backgroundTrackLayer.colors = [NSArray arrayWithObjects:(id)backgroundStart, (id)backgroundMiddle, (id)backgroundEnd, nil];
		backgroundTrackLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.25],[NSNumber numberWithFloat:1.0], nil];
		CGColorRelease(backgroundStart);
		CGColorRelease(backgroundEnd);
	}
	return [backgroundTrackLayer retain];
}
#pragma mark -
#pragma mark Properties
@synthesize state;
@end