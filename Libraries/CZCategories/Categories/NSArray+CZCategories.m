//
//  NSArray+CZCategories.m
//  CZKit
//
//  Created by Carter Allen on 1/23/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

#import "NSArray+CZCategories.h"

@implementation NSArray (CZCategories)
- (BOOL)cz_containsOnlyStrings {
	for (id i in self) { if ([i class] != [NSString class]) return NO; }
	return YES;
}
#ifndef CZ_NAMESPACE_PARANOIA
- (BOOL)containsOnlyStrings { return [self cz_containsOnlyStrings]; }
#endif
@end