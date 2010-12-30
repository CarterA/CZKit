//
//  NSObject+CZCategories.m
//  CZKit
//
//  Created by Carter Allen on 12/29/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "NSObject+CZCategories.h"

@implementation NSObject (CZCategories)
- (id)cz_associatedObjectForKey:(NSString *)key { return objc_getAssociatedObject(self, key); }
- (void)cz_setAssociatedObject:(id)object forKey:(NSString *)key withPolicy:(objc_AssociationPolicy)policy { objc_setAssociatedObject(self, key, object, policy); }
#ifndef CZ_NAMESPACE_PARANOIA
- (id)associatedObjectForKey:(NSString *)key { return [self cz_associatedObjectForKey:key]; }
- (void)setAssociatedObject:(id)object forKey:(NSString *)key withPolicy:(objc_AssociationPolicy)policy { [self cz_setAssociatedObject:object forKey:key withPolicy:policy]; }
#endif
@end