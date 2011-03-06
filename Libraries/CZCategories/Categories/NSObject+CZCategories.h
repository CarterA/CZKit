//
//  NSObject+CZCategories.h
//  CZKit
//
//  Created by Carter Allen on 12/29/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import <objc/runtime.h>

@interface NSObject (CZCategories)
- (id)cz_associatedObjectForKey:(NSString *)key;
- (void)cz_setAssociatedObject:(id)object forKey:(NSString *)key withPolicy:(objc_AssociationPolicy)policy;
#ifndef CZ_NAMESPACE_PARANOIA
- (id)associatedObjectForKey:(NSString *)key;
- (void)setAssociatedObject:(id)object forKey:(NSString *)key withPolicy:(objc_AssociationPolicy)policy;
#endif
@end