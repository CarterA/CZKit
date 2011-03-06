//
//  NSArray+CZCategories.h
//  CZKit
//
//  Created by Carter Allen on 1/23/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

/** Includes a method that checks if the array contains only strings.￼

Currently this category only adds one method.

*/

@interface NSArray (CZCategories)
/** Check if the array contains only NSString objects.

This method iterates through members of the array until it finds an object that is not an NSString, at
 which point it returns NO. If it makes it through the entire array, then it will return YES.

@return YES if the array contains only strings, NO if contains has any non-string objects.
*/
- (BOOL)cz_containsOnlyStrings;
#ifndef CZ_NAMESPACE_PARANOIA
- (BOOL)containsOnlyStrings;
#endif
@end