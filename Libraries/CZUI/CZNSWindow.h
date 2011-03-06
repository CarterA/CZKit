//
//  CZNSWindow.h
//  CZKit
//
//  Created by Carter Allen on 2/16/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#if !TARGET_OS_IPHONE

@class CZWindow;

typedef enum {
	CZNSWindowTypeTitled,
	CZNSWindowTypeTransparent,
} CZNSWindowType;

@interface CZNSWindow : NSWindow {}
- (id)initWithCZWindow:(CZWindow *)window type:(CZNSWindowType)type;
@end

#endif