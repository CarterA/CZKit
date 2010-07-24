//
//  NSImage+CZCategories.h
//  CZKit
//
//  Created by Carter Allen on 12/28/09.
//  Copyright 2009 Carter Allen. All rights reserved.
//

/** Adds a method for initializing an NSImage object based on the contents of an NSView.￼*/

#if !TARGET_OS_IPHONE
@interface NSImage (CZCategories)
#pragma mark View Conversion
/** Initializes an NSImage object based on the contents of the provided NSView.￼

This method takes the contents of the NSView provided and makes an NSImage that mirrors that view.
 This is an effective method of taking a "screenshot" of a particular region or section of an interface.

@param view The NSView instance to be mirrored by the resulting NSImage.
@result An initialized NSImage object that mirrors the provided NSView.
*/
- (NSImage *)cz_initWithContentsOfView:(NSView *)view;
#ifndef CZ_NAMESPACE_PARANOIA
- (NSImage *)initWithContentsOfView:(NSView *)view;
#endif
@end
#endif