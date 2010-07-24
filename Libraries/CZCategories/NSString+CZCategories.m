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
- (BOOL)cz_isEmpty {
	return [self cz_isEmptyIgnoringWhitespace:YES];
}
#ifndef CZ_NAMESPACE_PARANOIA
- (BOOL)isEmpty { return [self cz_isEmpty]; }
#endif
- (BOOL)cz_isEmptyIgnoringWhitespace:(BOOL)ignoresWhitespace {
	NSString *stringToCheck = (ignoresWhitespace) ? [self cz_stringByTrimmingWhitespace] : self;
	return [stringToCheck isEqualToString:@""];
}
#ifndef CZ_NAMESPACE_PARANOIA
- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoresWhitespace { return [self cz_isEmptyIgnoringWhitespace:ignoresWhitespace]; }
#endif
#pragma mark Whitespace Removal
- (NSString *)cz_stringByTrimmingWhitespace {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
#ifndef CZ_NAMESPACE_PARANOIA
- (NSString *)stringByTrimmingWhitespace { return [self cz_stringByTrimmingWhitespace]; }
#endif
#pragma mark RegEx Support
- (BOOL)cz_matchesRegularExpression:(NSString *)expression {
	NSPredicate *regexSearch = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
	return [regexSearch evaluateWithObject:self];
}
#ifndef CZ_NAMESPACE_PARANOIA
- (BOOL)matchesRegularExpression:(NSString *)expression { return [self cz_matchesRegularExpression:expression]; }
#endif
@end