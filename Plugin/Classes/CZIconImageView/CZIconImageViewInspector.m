//
//  CZIconImageViewInspector.m
//  CZKit
//
//  Created by Carter Allen on 12/26/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CZIconImageViewInspector.h"

@implementation CZIconImageViewInspector
- (NSString *)viewNibName {
    return @"CZIconImageViewInspector";
}
- (void)refresh {
	// Synchronize your inspector's content view with the currently selected objects
	[super refresh];
}
@end