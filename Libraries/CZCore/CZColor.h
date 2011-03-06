//
//  CZColor.h
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZMacros.h"
#import "CZGraphics.h"

@class CZImage;

@interface CZColor : CZ_DYNAMIC_TYPE(NSObject, UIColor) {}

#if !TARGET_OS_IPHONE

// Convenience methods for creating autoreleased colors
+ (CZColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+ (CZColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
+ (CZColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (CZColor *)colorWithCGColor:(CGColorRef)cgColor;
+ (CZColor *)colorWithPatternImage:(CZImage *)image;
+ (CZColor *)colorWithPatternImageRef:(CGImageRef)imageRef; // Not available on iPhone (UIImage on iPhone is a toll free bridge with CGImageRef)

// Initializers for creating non-autoreleased colors
- (CZColor *)initWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
- (CZColor *)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
- (CZColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (CZColor *)initWithCGColorRef:(CGColorRef)cgColor;
- (CZColor *)initWithPatternImage:(CZImage *)image;
- (CZColor *)initWithPatternImageRef:(CGImageRef)imageRef;

// Some convenience methods to create colors.  These colors will be as calibrated as possible.
// These colors are cached.
+ (CZColor *)blackColor;      // 0.0 white 
+ (CZColor *)darkGrayColor;   // 0.333 white 
+ (CZColor *)lightGrayColor;  // 0.667 white 
+ (CZColor *)whiteColor;      // 1.0 white 
+ (CZColor *)grayColor;       // 0.5 white 
+ (CZColor *)redColor;        // 1.0, 0.0, 0.0 RGB 
+ (CZColor *)greenColor;      // 0.0, 1.0, 0.0 RGB 
+ (CZColor *)blueColor;       // 0.0, 0.0, 1.0 RGB 
+ (CZColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB 
+ (CZColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB 
+ (CZColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB 
+ (CZColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB 
+ (CZColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB 
+ (CZColor *)brownColor;      // 0.6, 0.4, 0.2 RGB 
+ (CZColor *)clearColor;      // 0.0 white, 0.0 alpha 

// Set the color: Sets the fill and stroke colors in the current drawing context. Should be implemented by subclassers.
- (void)set;

// Set the fill or stroke colors individually. These should be implemented by subclassers.
- (void)setFill;
- (void)setStroke;

// Returns a color in the same color space as the receiver with the specified alpha component.
- (CZColor *)colorWithAlphaComponent:(CGFloat)alpha;

// Access the underlying CGColor
@property(nonatomic,readonly) CGColorRef CGColor;

// Converts to NSColor
@property(nonatomic,readonly) NSColor *NSColor;
#endif

@end