//
//  CZNSWindow.m
//  CZKit
//
//  Created by Carter Allen on 2/16/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#if !TARGET_OS_IPHONE

#import "CZNSWindow.h"
#import "CZWindow.h"

@interface CZNSWindow ()
@property (nonatomic, assign) CZWindow *CZWindow;
@end

@implementation CZNSWindow
@synthesize CZWindow=_CZWindow;
- (id)initWithCZWindow:(CZWindow *)window type:(CZNSWindowType)type {
	self = [super initWithContentRect:[window frame] styleMask:(NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask) backing:NSBackingStoreBuffered defer:YES];
	if (self) {
		self.CZWindow = window;
	}
	return self;
}
- (void)sendEvent:(NSEvent *)event {
	[self.CZWindow sendEvent:event];
}
@end

#endif // !TARGET_OS_IPHONE