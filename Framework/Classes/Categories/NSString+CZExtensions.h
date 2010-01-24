//
//  NSString+CZExtensions.h
//  CZKit
//
//  Created by Carter Allen on 1/14/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CZExtensions)
#pragma mark Emptiness Checking
- (BOOL)isEmpty;
- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoresWhitespace;
#pragma mark Whitespace Removal
- (NSString *)stringByTrimmingWhitespace;
#pragma mark RegEx Support
- (BOOL)matchesRegularExpression:(NSString *)expression;
@end