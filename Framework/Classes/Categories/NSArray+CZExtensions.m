//
//  NSArray+CZExtensions.m
//  CZKit
//
//  Created by Carter Allen on 1/23/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "NSArray+CZExtensions.h"


@implementation NSArray (CZExtensions)
- (BOOL)containsOnlyStrings {
	for (id i in self) { if ([i class] != [NSString class]) return NO; }
	return YES;
}
@end