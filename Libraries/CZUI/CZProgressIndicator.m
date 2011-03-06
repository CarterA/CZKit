//
//  CZProgressIndicator.m
//  Campus
//
//  Created by Carter Allen on 1/21/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZProgressIndicator.h"

@interface CZProgressIndicatorPinstripeAnimation : NSAnimation {}
@property (nonatomic, assign) CZProgressIndicator *indicator;
@end

#define CZ_PROGRESS_INDICATOR_CAP_WIDTH lroundf((self.bounds.size.height/2))
#define CZ_PROGRESS_INDICATOR_ANIMATION_SPEED 1.5

typedef enum {
	CZProgressIndicatorLeftCapComponent = 1,
	CZProgressIndicatorRightCapComponent = 2,
	CZProgressIndicatorFillComponent = 3
} CZProgressIndicatorComponent;

@interface CZProgressIndicator()
@property (nonatomic, retain) __attribute__((NSObject)) CGImageRef pinstripes;
@property (nonatomic, retain) CZProgressIndicatorPinstripeAnimation *pinstripeAnimation;
@property (nonatomic, assign) CGFloat pinstripeOffset;
- (void)incrementAnimation;
- (CGRect)rectForComponent:(CZProgressIndicatorComponent)component;
//- (void)drawComponent:(CZProgressIndicatorComponent)component;
@end

@implementation CZProgressIndicatorPinstripeAnimation
@synthesize indicator;
- (void)setCurrentProgress:(NSAnimationProgress)progress {
    // Call super to update the progress value.
    [super setCurrentProgress:progress-1]; // Except not.
	[self.indicator incrementAnimation];
}
@end

@implementation CZProgressIndicator

#pragma mark -
#pragma mark Properties
@synthesize value, range, controlSize, indeterminate;
@synthesize pinstripes, pinstripeAnimation, pinstripeOffset;

#pragma mark -
#pragma mark Initialization
- (id)initWithFrame:(NSRect)frameRect {
	if ((self = [super initWithFrame:frameRect])) {
	}
	return self;
}
- (void)awakeFromNib {
	
	self.pinstripeAnimation = [[CZProgressIndicatorPinstripeAnimation alloc] initWithDuration:10 animationCurve:NSAnimationLinear];
	[self.pinstripeAnimation startWhenAnimation:self.pinstripeAnimation reachesProgress:1.0];
	self.pinstripeAnimation.animationBlockingMode = NSAnimationNonblocking;
	self.pinstripeAnimation.indicator = self;
	
	[self incrementAnimation];
	
	self.pinstripeOffset = 0;
}

#pragma mark -
#pragma mark Accessors
- (void)start {
	[self.pinstripeAnimation startAnimation];
}
- (void)stop {
	[self.pinstripeAnimation stopAnimation];
}

#pragma mark -
#pragma mark Geometry
- (CGRect)rectForComponent:(CZProgressIndicatorComponent)component {
	CGRect rect = CGRectMake(0, 0, 0, self.bounds.size.height);
	switch (component) {
		case CZProgressIndicatorLeftCapComponent: {
			rect.size.width = CZ_PROGRESS_INDICATOR_CAP_WIDTH;
			break;
		}
		case CZProgressIndicatorRightCapComponent: {
			rect.origin.x = self.bounds.size.width - CZ_PROGRESS_INDICATOR_CAP_WIDTH;
			rect.size.width = CZ_PROGRESS_INDICATOR_CAP_WIDTH;
			break;
		}
		case CZProgressIndicatorFillComponent: {
			//rect.origin.x = CZ_PROGRESS_INDICATOR_CAP_WIDTH;
			//rect.size.width = self.bounds.size.width - (2 * CZ_PROGRESS_INDICATOR_CAP_WIDTH);
			rect.size.width = self.bounds.size.width;
			break;
		}
		default:
			break;
	}
	return rect;
}

#pragma mark -
#pragma mark Drawing
- (void)incrementAnimation {
	if (self.pinstripeOffset > self.frame.size.width) self.pinstripeOffset = 0;
	else self.pinstripeOffset = self.pinstripeOffset + CZ_PROGRESS_INDICATOR_ANIMATION_SPEED;
	self.pinstripeAnimation.duration = 10;
	[self setNeedsDisplay:YES];
}
- (void)drawRect:(NSRect)dirtyRect {
	
	CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextSetAlpha(context, 0.2);
	if (!self.pinstripes) self.pinstripes = [[NSImage imageNamed:@"Pinstripes"] CGImageForProposedRect:NULL context:[NSGraphicsContext currentContext] hints:nil];
	CGContextClipToRect(context, CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height));
	CGContextTranslateCTM(context, -self.pinstripeOffset, 0);
	CGContextDrawTiledImage(context, CGRectMake(0, 0, 45.0f, 45.0f), self.pinstripes);
	
}
/*- (void)drawRect:(NSRect)dirtyRect {
 if (CGRectIntersectsRect(dirtyRect, [self rectForComponent:CZProgressIndicatorLeftCapComponent]))
 [self drawComponent:CZProgressIndicatorLeftCapComponent];
 if (CGRectIntersectsRect(dirtyRect, [self rectForComponent:CZProgressIndicatorRightCapComponent]))
 [self drawComponent:CZProgressIndicatorRightCapComponent];
 if (CGRectIntersectsRect(dirtyRect, [self rectForComponent:CZProgressIndicatorFillComponent]))
 [self drawComponent:CZProgressIndicatorFillComponent];
 }
 - (void)drawComponent:(CZProgressIndicatorComponent)component {
 CGRect rect = [self rectForComponent:component];
 CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
 switch (component) {
 case CZProgressIndicatorLeftCapComponent: {
 CGMutablePathRef path = CGPathCreateMutable();
 CGPathMoveToPoint(path, NULL, rect.size.width, 0);
 CGPathAddArcToPoint(path, NULL, rect.size.width, 0,  0, rect.size.height/2, rect.size.width);
 CGPathAddArcToPoint(path, NULL, 0, rect.size.height/2, rect.size.width, rect.size.height, rect.size.width);
 CGContextAddPath(context, path);
 CGContextSetStrokeColorWithColor(context, CGColorGetConstantColor(kCGColorBlack));
 CGContextStrokePath(context);
 CGPathRelease(path);
 break;
 }
 case CZProgressIndicatorRightCapComponent: {
 CGContextSetFillColorWithColor(context, CGColorGetConstantColor(kCGColorBlack));
 CGContextFillRect(context, rect);
 break;
 }
 case CZProgressIndicatorFillComponent: {
 NSGradient *backgroundGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.6 green:0.6 blue:0.65 alpha:1.000] endingColor:[NSColor colorWithCalibratedRed:0.48 green:0.48 blue:0.52 alpha:1.000]];
 [backgroundGradient drawInRect:rect angle:270];
 NSColor *pattern = [NSColor colorWithPatternImage:[NSImage imageNamed:@"Pinstripes"]];
 [pattern setFill];
 [NSBezierPath fillRect:rect];
 break;
 }
 default:
 break;
 }
 }*/

@end