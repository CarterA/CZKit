//
//  CZDisclosureViewInspector.m
//  CZKit
//
//  Created by Carter Allen on 2/9/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "CZDisclosureViewInspector.h"

@implementation CZDisclosureViewInspector
- (NSString *)viewNibName { return @"CZDisclosureViewInspector"; }
- (void)refresh { [super refresh]; }
- (void)ibDidAddToDesignableDocument:(IBDocument *)document { [super ibDidAddToDesignableDocument:document]; }
@end