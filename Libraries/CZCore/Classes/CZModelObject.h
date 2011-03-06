//
//  CZModelObject.h
//  CZKit
//
//  Created by Carter Allen on 2/5/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

/** An abstract base class for model objects that automatically
 handles a lot of mundane and annoying takes.
 
 The following property types are fully supported:
 
 - Any NSObject class that conforms to NSCoding
 - NSPoint/CGPoint
 - NSSize/CGSize
 - NSRect/CGRect
 - NSInteger
 - NSUInteger
 - CGFloat
 
*/
#if !TARGET_OS_IPHONE
@interface CZModelObject : NSObject <NSCoding> {}

//- (BOOL)isEqualToModelObject:(CZModelObject *)otherModelObject;

@end
#endif