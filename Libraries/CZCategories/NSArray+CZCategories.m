//
//  NSArray+CZCategories.m
//  CZKit
//
//  Created by Carter Allen on 1/23/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

#import "NSArray+CZCategories.h"

@implementation NSArray (CZCategories)
- (BOOL)containsOnlyStrings {
	for (id i in self) { if ([i class] != [NSString class]) return NO; }
	return YES;
}
@end