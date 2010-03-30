//
//  NSColor+CZExtensions.m
//  CZKit
//
//  Created by Carter Allen on 3/29/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "NSColor+CZExtensions.h"

@implementation NSColor (CZExtensions)
- (CGColorRef)CGColor {
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
@end