//
//  CZColor.m
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZColor.h"

#if !TARGET_OS_IPHONE

@interface CZColor () {
	CGColorRef CGColor;
}
@end

CGPatternRef CreateImagePattern(CGImageRef image);
CGColorRef CreatePatternColor(CGImageRef image);	

#endif

@implementation CZColor

#if !TARGET_OS_IPHONE

// Convenience methods for creating autoreleased colors
+ (CZColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	return [[[CZColor alloc] initWithWhite:white alpha:alpha] autorelease];
}

+ (CZColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
	return [[[CZColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha] autorelease];
}

+ (CZColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return [[[CZColor alloc] initWithRed:red green:green blue:blue alpha:alpha] autorelease];
}

+ (CZColor *)colorWithCGColor:(CGColorRef)cgColor {
	return [[[CZColor alloc] initWithCGColorRef:cgColor] autorelease];
}

+ (CZColor *)colorWithPatternImage:(CZImage *)image {
	return [[[CZColor alloc] initWithPatternImage:image] autorelease];
}

+ (CZColor *)colorWithPatternImageRef:(CGImageRef)imageRef {
	return [[[CZColor alloc] initWithPatternImageRef:imageRef] autorelease];
}

// Initializers for creating non-autoreleased colors
- (CZColor *)initWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	if((self = [super init])) {
		CGColor = CGColorCreateGenericGray(white, alpha);
	}
	
	return self;
}

- (CZColor *)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
	hue = roundf(hue * 100) / 100;
	saturation = roundf(saturation * 100) / 100;
	brightness = roundf(brightness * 100) / 100;
	
	NSInteger hexBrightness = (NSInteger)roundf(brightness * 2.55f);
	NSInteger red = 0;
	NSInteger green = 0;
	NSInteger blue = 0;
	
	if (saturation == 0.0f) {
		red = green = blue = hexBrightness;
	} else {
		
		NSInteger Hi = floor(hue / 60);
		NSInteger f = hue / 60 - Hi;
		NSInteger p = round(brightness * (100 - saturation) * .0255);
		NSInteger q = round(brightness * (100 - f * saturation) * .0255);
		NSInteger t = round(brightness * (100 - (1 - f) * saturation) * .0255);
		
		switch (Hi) {
			case 0:
				red = hexBrightness;
				green = t;
				blue = p;
				break;
			case 1:
				red = q;
				green = hexBrightness;
				blue = p;
				break;
			case 2:
				red = p;
				green = hexBrightness;
				blue = t;
				break;
			case 3:
				red = p;
				green = q;
				blue = hexBrightness;
				break;
			case 4:
				red = t;
				green = p;
				blue = hexBrightness;
				break;
			case 5:
				red = hexBrightness;
				green = p;
				blue = q;
		}
	}
	
	return [self initWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];  
}

- (CZColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	if((self = [super init])) {
		CGColor = CGColorCreateGenericRGB(red, green, blue, alpha);
	}
	
	return self;
}

- (CZColor *)initWithCGColorRef:(CGColorRef)cgColor {
	if((self = [super init])) {
		CGColor = CGColorRetain(cgColor);
	}
	
	return self;
}

- (CZColor *)initWithPatternImage:(CZImage*)image {
	return nil;
}

- (CZColor *)initWithPatternImageRef:(CGImageRef)imageRef {
	if((self = [super init])) {
		CGColor = CreatePatternColor(imageRef);	
	}
	
	return self;
}

+ (CZColor *)blackColor {
	return [CZColor colorWithWhite:0.0f alpha:1.0f];
}

+ (CZColor *)darkGrayColor {
	return [CZColor colorWithWhite:0.333f alpha:1.0f];
}

+ (CZColor *)lightGrayColor {
	return [CZColor colorWithWhite:0.667f alpha:1.0f];
}

+ (CZColor *)whiteColor {
	return [CZColor colorWithWhite:1.0f alpha:1.0f];
}

+ (CZColor *)grayColor {
	return [CZColor colorWithWhite:0.5f alpha:1.0f];
}

+ (CZColor *)redColor {
	return [CZColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
}

+ (CZColor *)greenColor {
	return [CZColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1.0f];
}

+ (CZColor *)blueColor {
	return [CZColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:1.0f];
}

+ (CZColor *)cyanColor {
	return [CZColor colorWithRed:0.0f green:1.0f blue:1.0f alpha:1.0f];
}

+ (CZColor *)yellowColor {
	return [CZColor colorWithRed:1.0f green:1.0f blue:0.0f alpha:1.0f];
}

+ (CZColor *)magentaColor {
	return [CZColor colorWithRed:1.0f green:0.0f blue:1.0f alpha:1.0f];
}

+ (CZColor *)orangeColor {
	return [CZColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:1.0f];
}

+ (CZColor *)purpleColor {
	return [CZColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0f];
}

+ (CZColor *)brownColor {
	return [CZColor colorWithRed:0.6f green:0.4f blue:0.2f alpha:1.0f];
}

+ (CZColor *)clearColor {
	return [CZColor colorWithWhite:0.0f alpha:0.0f];
}

// Set the color: Sets the fill and stroke colors in the current drawing context. Should be implemented by subclassers.
- (void)set {
	[self setFill];
	[self setStroke];
}

// Set the fill or stroke colors individually. These should be implemented by subclassers.
- (void)setFill {
	CGContextRef ref = CZGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(ref, CGColor);
}

- (void)setStroke {
	CGContextRef ref = CZGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(ref, CGColor);
}

// Returns a color in the same color space as the receiver with the specified alpha component.
- (CZColor *)colorWithAlphaComponent:(CGFloat)alpha {
	CGColorRef cgColor = CGColorCreateCopyWithAlpha(self.CGColor, alpha);
	CZColor* color = [CZColor colorWithCGColor:cgColor];
	CGColorRelease(cgColor);
	return color;
}

- (CGColorRef)CGColor {
	return CGColor;
}

- (NSColor*)NSColor {
	NSColorSpace* colorSpace = [[[NSColorSpace alloc] initWithCGColorSpace:CGColorGetColorSpace(self.CGColor)] autorelease];
	const CGFloat* components = (const CGFloat*)CGColorGetComponents(self.CGColor);
	NSInteger numberOfComponents = CGColorGetNumberOfComponents(self.CGColor);
	
	return [NSColor colorWithColorSpace:colorSpace components:components count:numberOfComponents];
}

- (BOOL)isEqual:(CZColor*)aColor {
	if(![aColor isKindOfClass:[CZColor class]]) return NO;
	return CGColorEqualToColor(self.CGColor, aColor.CGColor);
}

- (void)dealloc {
	CGColorRelease(CGColor);
	[super dealloc];
}

#endif

@end

#if !TARGET_OS_IPHONE

/*
 * @see http://developer.apple.com/mac/library/samplecode/GeekGameBoard/listing38.html
 */

// callback for CreateImagePattern.
static void drawPatternImage (void *info, CGContextRef ctx) {
    CGImageRef image = (CGImageRef) info;
    CGContextDrawImage(ctx, 
                       CGRectMake(0,0, CGImageGetWidth(image),CGImageGetHeight(image)),
                       image);
}

// callback for CreateImagePattern.
static void releasePatternImage( void *info ) {
    CGImageRelease( (CGImageRef)info );
}


CGPatternRef CreateImagePattern(CGImageRef image) {
    NSCParameterAssert(image);
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    static const CGPatternCallbacks callbacks = {0, &drawPatternImage, &releasePatternImage};
    return CGPatternCreate (image,
                            CGRectMake (0, 0, width, height),
                            CGAffineTransformMake (1, 0, 0, 1, 0, 0),
                            width,
                            height,
                            kCGPatternTilingConstantSpacing,
                            true,
                            &callbacks);
}


CGColorRef CreatePatternColor(CGImageRef image) {
    CGPatternRef pattern = CreateImagePattern(image);
    CGColorSpaceRef space = CGColorSpaceCreatePattern(NULL);
    CGFloat components[1] = {1.0};
    CGColorRef color = CGColorCreateWithPattern(space, pattern, components);
    CGColorSpaceRelease(space);
    CGPatternRelease(pattern);
    return color;
}

#endif