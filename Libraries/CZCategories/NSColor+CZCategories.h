//
//  NSColor+CZCategories.h
//  CZKit
//
//  Created by Carter Allen on 3/29/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

/** Adds a method for obtaining a CGColorRef equivalent to the receiver.￼
 
 The iPhone OS's class UIColor has a convenience method, -CGColor, that helps a lot when writing CoreGraphics code. NSColor is missing this method out-of-the-box, thus this category.
 
 */

#if !TARGET_OS_IPHONE
@interface NSColor (CZCategories)
/** Obtain a CGColorRef based on the receiver.
 
 This method calculates and returns a CGColorRef with the same colorspace and components as the receiver. It also contains exception handling that returns a clear color if the receiver is a pattern, as CGColorRefs cannot contain patterns.
 
 @return A CGColorRef with the same colorspace and components as the receiver.
 */
- (CGColorRef)cz_CGColor;
#ifndef CZ_NAMESPACE_PARANOIA
- (CGColorRef)CGColor;
#endif
@end
#endif