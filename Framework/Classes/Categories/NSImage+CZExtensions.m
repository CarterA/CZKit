//
//  NSImage+CZExtensions.m
//  CZKit
//
//  Created by Carter Allen on 12/28/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "NSImage+CZExtensions.h"

@implementation NSImage (CZExtensions)
#pragma mark View Conversion
- (NSImage *)initWithContentsOfView:(NSView *)view {
	if (self == [super init]) {
		NSPDFImageRep *imageRep = [NSPDFImageRep imageRepWithData:[view dataWithPDFInsideRect:[view bounds]]];
		self = [[NSImage alloc] initWithSize:[imageRep size]];
		[self addRepresentation:imageRep];
	}
	return self;
}
@end