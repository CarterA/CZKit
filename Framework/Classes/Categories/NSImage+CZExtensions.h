//
//  NSImage+CZExtensions.h
//  CZKit
//
//  Created by Carter Allen on 12/28/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

/** Adds a method for initializing an NSImage object based on the contents of an NSView.￼*/

#import <Foundation/Foundation.h>

@interface NSImage (CZExtensions)
#pragma mark View Conversion
/** Initializes an NSImage object based on the contents of the provided NSView.￼

This method takes the contents of the NSView provided and makes an NSImage that mirrors that view.
 This is an effective method of taking a "screenshot" of a particular region or section of an interface.

@param view The NSView instance to be mirrored by the resulting NSImage.
@result An initialized NSImage object that mirrors the provided NSView.
*/
- (NSImage *)initWithContentsOfView:(NSView *)view;
@end