//
//  NSImage+CZExtensions.h
//  CZKit
//
//  Created by Carter Allen on 12/28/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSImage (CZExtensions)
#pragma mark View Conversion
- (NSImage *)initWithContentsOfView:(NSView *)view;
@end
