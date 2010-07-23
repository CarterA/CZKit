//
//  NSImage+CZCategories.m
//  CZKit
//
//  Created by Carter Allen on 12/28/09.
//  Copyright 2009 Carter Allen. All rights reserved.
//

#import "NSImage+CZCategories.h"

#if !TARGET_OS_IPHONE
@implementation NSImage (CZCategories)
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
#endif