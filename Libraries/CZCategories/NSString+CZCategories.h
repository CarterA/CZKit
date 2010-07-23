//
//  NSString+CZCategories.h
//  CZKit
//
//  Created by Carter Allen on 1/14/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//
/** Adds methods for checking if a string is empty, as well as removing empty characters and basic RegEx support. */

#import <Foundation/Foundation.h>

@interface NSString (CZCategories)
#pragma mark Emptiness Checking
/** Checks whether the NSString object is empty.￼

This is a convenience method which runs isEmptyIgnoringWhitespace:YES.

@return The result of isEmptyIgnoringWhitespace:YES.
@see isEmptyIgnoringWhitespace:
*/
- (BOOL)isEmpty;
/** Checks whether the NSString￼ object is empty, optionally ignoring whitespace.

@param ignoresWhitespace Whether or not to count whitespace as empty or not. YES will count whitespace as empty,
 NO will not.
@return YES if the string is empty, NO if the string contains characters.
*/
- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoresWhitespace;
#pragma mark Whitespace Removal
/** Create a new NSString object by removing whitespace from the beginning and end of the original NSString.￼

This will remove characters in the whitespaceCharacterSet, as defined by NSCharacterSet.

@return An initialized string based on the original with whitespace trimmed off.
*/
- (NSString *)stringByTrimmingWhitespace;
#pragma mark RegEx Support
/** Uses NSPredicate to check if the NSString matches the provided regular expression.￼

This is only for very simple RegEx needs, as it simply wraps NSPredicate.

@param expression A regular expression.
@return YES if the NSString matches the expression, and NO if it does not.
*/
- (BOOL)matchesRegularExpression:(NSString *)expression;
@end