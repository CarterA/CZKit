/*
 
 CZAppPrefs.h
 An object-oriented, KVC-compliant, efficient, and powerful class for
 reading and writing to other app's preference files.
 
 Messing with another app's preferences is bad programming juju.
 Use your powers for good.
 
 This class is a member of the CZKit framework.
 
 Created by Carter Allen on 12/10/09.
 Copyright 2010 Carter Allen. All rights reserved.
 
 For usage information, please see the included documentation.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import <Cocoa/Cocoa.h>

typedef enum {
	CZAppPrefsSuccessful,
	CZAppPrefsAppNotFound,
	CZAppPrefsKeyNotFound,
	CZAppPrefsKeyNotOfExpectedType
} CZAppPrefsResponse;

@interface CZAppPrefs : NSObject {
	BOOL global;
	NSString *bundleID;
}
#pragma mark Initializers
+ (CZAppPrefs *)prefsForBundleID:(NSString *)identifier;
- (id)initWithBundleID:(NSString *)identifier;
#pragma mark Accessors
- (NSArray *)arrayForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
- (BOOL)boolForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
- (NSData *)dataForKey:(NSString *)key;
- (NSData *)dataForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
- (float)floatForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
- (int)integerForKey:(NSString *)key;
- (int)integerForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
- (id)objectForKey:(NSString *)key;
- (id)objectForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
- (NSArray *)stringArrayForKey:(NSString *)key;
- (NSArray *)stringArrayForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
- (NSString *)stringForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
- (double)doubleForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
- (NSURL *)URLForKey:(NSString *)key;
- (NSURL *)URLForKey:(NSString *)key response:(CZAppPrefsResponse *)response;
#pragma mark Setters
- (void)setBool:(BOOL)value forKey:(NSString *)key;
- (void)setFloat:(float)value forKey:(NSString *)key;
- (void)setInteger:(int)value forKey:(NSString *)key;
- (void)setObject:(id)value forKey:(NSString *)key;
- (void)setDouble:(double)value forKey:(NSString *)key;
- (void)setURL:(NSURL *)value forKey:(NSString *)key;
#pragma mark Properties
@property (assign) BOOL global;
@property (assign) NSString *bundleID;
@end