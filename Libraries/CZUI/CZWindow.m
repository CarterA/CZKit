//
//  CZWindow.m
//  CZKit
//
//  Created by Carter Allen on 1/31/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZWindow.h"

@implementation CZWindow
- (void)setFrame:(NSRect)newFrame {
	[self setFrame:newFrame display:YES animate:YES];
}
@end