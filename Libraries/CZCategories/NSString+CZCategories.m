//
//  NSString+CZCategories.m
//  CZKit
//
//  Created by Carter Allen on 1/14/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

#import "NSString+CZCategories.h"

@implementation NSString (CZCategories)
#pragma mark Emptiness Checking
- (BOOL)isEmpty {
	return [self isEmptyIgnoringWhitespace:YES];
}
- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoresWhitespace {
	NSString *stringToCheck = (ignoresWhitespace) ? [self stringByTrimmingWhitespace] : self;
	return [stringToCheck isEqualToString:@""];
}
#pragma mark Whitespace Removal
- (NSString *)stringByTrimmingWhitespace {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
#pragma mark RegEx Support
- (BOOL)matchesRegularExpression:(NSString *)expression {
	NSPredicate *regexSearch = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
	return [regexSearch evaluateWithObject:self];
}
@end