//
//  CZObnoxiousToggle.h
//  CZKit
//
//  Created by Carter Allen on 12/9/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>
#import "NSColor+CZExtensions.h"

@interface CZObnoxiousToggle : NSView {
	NSCellStateValue state;
	CALayer *knobMaskLayer;
	CAGradientLayer *knobLayer;
	CAGradientLayer *backgroundTrackLayer;
}
#pragma mark -
#pragma mark Properties
@property (assign) NSCellStateValue state;
@property (readonly) CALayer *knobMaskLayer;
@property (readonly) CAGradientLayer *knobLayer;
@property (readonly) CAGradientLayer *backgroundTrackLayer;
@end