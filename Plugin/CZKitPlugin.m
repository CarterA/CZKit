//
//  CZKitPlugin.m
//  CZKit
//
//  Created by Carter Allen on 12/26/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CZKitPlugin.h"

@implementation CZKitPlugin
- (NSArray *)libraryNibNames {
    return [NSArray arrayWithObjects:@"CZKitLibrary", nil];
}
- (NSArray *)requiredFrameworks {
    return [NSArray arrayWithObjects:[NSBundle bundleWithIdentifier:@"com.cz.CZKit"], nil];
}
- (NSString *)label {
	return @"CZKit";
}
@end