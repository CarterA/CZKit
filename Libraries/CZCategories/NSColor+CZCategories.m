//
//  NSColor+CZCategories.m
//  CZKit
//
//  Created by Carter Allen on 3/29/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

#if !TARGET_OS_IPHONE

#import "NSColor+CZCategories.h"

@implementation NSColor (CZCategories)
- (CGColorRef)cz_CGColor {
	CGColorRef color;
	@try {
		NSInteger componentCount = [self numberOfComponents];    
		CGColorSpaceRef cgColorSpace = [[self colorSpace] CGColorSpace];
		CGFloat *components = (CGFloat *)calloc(componentCount, sizeof(CGFloat));
		if (!components) {
			NSException *exception = [NSException exceptionWithName:NSMallocException reason:@"Unable to malloc color components" userInfo:nil];
			@throw exception;
		}
		[self getComponents:components];
		color = CGColorCreate(cgColorSpace, components);
		free(components);
	} 
	@catch (NSException *e) { return CGColorGetConstantColor(kCGColorClear); }
	return (CGColorRef)[(id)color autorelease];
}
#ifndef CZ_NAMESPACE_PARANOIA
- (CGColorRef)CGColor { return [self cz_CGColor]; }
#endif
- (NSString *)cz_hexidecimalValue {
	NSColor *convertedColor=[self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	if(convertedColor) return [NSString stringWithFormat:@"%@%@%@", [NSString stringWithFormat:@"%02x", (NSInteger)(convertedColor.redComponent * 255.99999f)], [NSString stringWithFormat:@"%02x", (NSInteger)(convertedColor.greenComponent * 255.99999f)], [NSString stringWithFormat:@"%02x", (NSInteger)(convertedColor.blueComponent * 255.99999f)]];
	return nil;
}
#ifndef CZ_NAMESPACE_PARANOIA
- (NSString *)hexidecimalValue { return [self cz_hexidecimalValue]; }
#endif
@end
#endif