//
//  CZAppPrefs.m
//  CZKit
//
//  Created by Carter Allen on 12/21/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CZAppPrefs.h"
#import "../Categories/NSArray+CZExtensions.h"

@interface CZAppPrefs (Private)
- (BOOL)appExists;
@end

@implementation CZAppPrefs
#pragma mark Initializers
+ (CZAppPrefs *)prefsForBundleID:(NSString *)identifier {
	return [[[self alloc] initWithBundleID:identifier] autorelease];
}
- (id)initWithBundleID:(NSString *)identifier {
	if (self = [super init]) {
		self.bundleID = identifier;
		self.global = NO;
	}
	return self;
}
#pragma mark Accessors
- (NSArray *)arrayForKey:(NSString *)key {
	return [self arrayForKey:key response:nil];
}
- (NSArray *)arrayForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
	NSArray *result = nil;
    if ([self appExists]) {
        CFTypeRef rawValue = CFPreferencesCopyValue((CFStringRef)key, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
        if (rawValue == NULL) { if (response) *response = CZAppPrefsKeyNotFound; } 
		else if (CFArrayGetTypeID() == CFGetTypeID(rawValue)) {
            if (response) *response = CZAppPrefsSuccessful;
            result = [[(NSArray *)rawValue retain] autorelease];
        }
		else { if (response) *response = CZAppPrefsKeyNotOfExpectedType; }
		if (rawValue) CFRelease(rawValue);
    } 
	else { if (response) *response = CZAppPrefsAppNotFound; }
    return result;
}
- (BOOL)boolForKey:(NSString *)key {
	return [self boolForKey:key response:nil];
}
- (BOOL)boolForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
	BOOL result = NO;
	if ([self appExists]) {
		CFPropertyListRef rawValue = CFPreferencesCopyValue((CFStringRef)key, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
		if (rawValue == NULL) { if (response) *response = CZAppPrefsKeyNotFound; }
		else {
			if (CFGetTypeID(rawValue) == CFBooleanGetTypeID()) {
				result = CFBooleanGetValue((CFBooleanRef)rawValue);
				if (response) *response = CZAppPrefsSuccessful;
			}
			else { if (response) *response = CZAppPrefsKeyNotOfExpectedType; }
			if (rawValue) CFRelease(rawValue);
		}
	}
	else { if (response) *response = CZAppPrefsAppNotFound; }
	return result;
}
- (NSData *)dataForKey:(NSString *)key {
	return [self dataForKey:key response:nil];
}
- (NSData *)dataForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
	NSData *result = nil;
    if ([self appExists]) {
        CFTypeRef rawValue = CFPreferencesCopyValue((CFStringRef)key, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
        if (rawValue == NULL) { if (response) *response = CZAppPrefsKeyNotFound; } 
		else if (CFDataGetTypeID() == CFGetTypeID(rawValue)) {
            if (response) *response = CZAppPrefsSuccessful;
            result = [[(NSData *)rawValue retain] autorelease];
        }
		else { if (response) *response = CZAppPrefsKeyNotOfExpectedType; }
		if (rawValue) CFRelease(rawValue);
    } 
	else { if (response) *response = CZAppPrefsAppNotFound; }
    return result;
}
- (NSDictionary *)dictionaryForKey:(NSString *)key {
	return [self dictionaryForKey:key response:nil];
}
- (NSDictionary *)dictionaryForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
	NSDictionary *result = nil;
    if ([self appExists]) {
        CFTypeRef rawValue = CFPreferencesCopyValue((CFStringRef)key, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
        if (rawValue == NULL) { if (response) *response = CZAppPrefsKeyNotFound; } 
		else if (CFDictionaryGetTypeID() == CFGetTypeID(rawValue)) {
            if (response) *response = CZAppPrefsSuccessful;
            result = [[(NSDictionary *)rawValue retain] autorelease];
        }
		else { if (response) *response = CZAppPrefsKeyNotOfExpectedType; }
		if (rawValue) CFRelease(rawValue);
    } 
	else { if (response) *response = CZAppPrefsAppNotFound; }
    return result;
}
- (float)floatForKey:(NSString *)key {
	return [self floatForKey:key response:nil];
}
- (float)floatForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
	float result = 0.0f;
	if ([self appExists]) {
		CFPropertyListRef rawValue = CFPreferencesCopyValue((CFStringRef)key, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
		if (rawValue == NULL) { if (response) *response = CZAppPrefsKeyNotFound; }
		else {
			NSArray *allowedTypes = [NSArray arrayWithObjects:[NSNumber numberWithInt:kCFNumberFloat32Type], [NSNumber numberWithInt:kCFNumberFloat64Type], [NSNumber numberWithInt:kCFNumberFloatType], nil];
			NSLog(@"%d", CFNumberGetType((CFNumberRef)rawValue));
			if ([allowedTypes containsObject:[NSNumber numberWithInt:CFNumberGetType((CFNumberRef)rawValue)]]) {
				CFNumberGetValue((CFNumberRef)rawValue, CFNumberGetType((CFNumberRef)rawValue), &result);
				if (response) *response = CZAppPrefsSuccessful;
			}
			else { if (response) *response = CZAppPrefsKeyNotOfExpectedType; }
			if (rawValue) CFRelease(rawValue);
		}
	}
	else { if (response) *response = CZAppPrefsAppNotFound; }
	return result;
}
- (int)integerForKey:(NSString *)key {
	return [self integerForKey:key response:nil];
}
- (int)integerForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
	int result = 0;
	if ([self appExists]) {
		CFPropertyListRef rawValue = CFPreferencesCopyValue((CFStringRef)key, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
		if (rawValue == NULL) { if (response) *response = CZAppPrefsKeyNotFound; }
		else {
			NSArray *allowedTypes = [NSArray arrayWithObjects:[NSNumber numberWithInt:kCFNumberSInt8Type], [NSNumber numberWithInt:kCFNumberSInt16Type], [NSNumber numberWithInt:kCFNumberSInt32Type], [NSNumber numberWithInt:kCFNumberSInt64Type], [NSNumber numberWithInt:kCFNumberIntType], nil];
			if ([allowedTypes containsObject:[NSNumber numberWithInt:CFNumberGetType((CFNumberRef)rawValue)]]) {
				CFNumberGetValue((CFNumberRef)rawValue, CFNumberGetType((CFNumberRef)rawValue), &result);
				if (response) *response = CZAppPrefsSuccessful;
			}
			else { if (response) *response = CZAppPrefsKeyNotOfExpectedType; }
			if (rawValue) CFRelease(rawValue);
		}
	}
	else { if (response) *response = CZAppPrefsAppNotFound; }
	return result;
}
- (id)objectForKey:(NSString *)key {
	return [self objectForKey:key response:nil];
}
- (id)objectForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
    id result = nil;
    if ([self appExists]) {
        CFTypeRef rawValue = CFPreferencesCopyValue((CFStringRef)key, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
        if (rawValue == NULL) { if (response) *response = CZAppPrefsKeyNotFound; } 
		else {
            if (response) *response = CZAppPrefsSuccessful;
            result = [[(id)rawValue retain] autorelease];
        }
		if (rawValue) CFRelease(rawValue);
    } 
	else { if (response) *response = CZAppPrefsAppNotFound; }
    return result;
}
- (NSArray *)stringArrayForKey:(NSString *)key {
	return [self stringArrayForKey:key response:nil];
}
- (NSArray *)stringArrayForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
	NSArray *result = [self arrayForKey:key response:response];
	if (![result containsOnlyStrings]) { if (response) *response = CZAppPrefsKeyNotOfExpectedType; }
    return result;
}
- (NSString *)stringForKey:(NSString *)key {
	return [self stringForKey:key response:nil];
}
- (NSString *)stringForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
	NSString *result = nil;
    if ([self appExists]) {
        CFTypeRef rawValue = CFPreferencesCopyValue((CFStringRef)key, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
        if (rawValue == NULL) { if (response) *response = CZAppPrefsKeyNotFound; } 
		else if (CFStringGetTypeID() == CFGetTypeID(rawValue)) {
            if (response) *response = CZAppPrefsSuccessful;
            result = [[(NSString *)rawValue retain] autorelease];
        }
		else { if (response) *response = CZAppPrefsKeyNotOfExpectedType; }
		if (rawValue) CFRelease(rawValue);
    } 
	else { if (response) *response = CZAppPrefsAppNotFound; }
    return result;
}
- (double)doubleForKey:(NSString *)key {
	return [self doubleForKey:key response:nil];
}
- (double)doubleForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
	double result = (double)0;
	if ([self appExists]) {
		CFPropertyListRef rawValue = CFPreferencesCopyValue((CFStringRef)key, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
		if (rawValue == NULL) { if (response) *response = CZAppPrefsKeyNotFound; }
		else {
			NSArray *allowedTypes = [NSArray arrayWithObjects:[NSNumber numberWithInt:kCFNumberDoubleType], [NSNumber numberWithInt:kCFNumberFloat32Type], [NSNumber numberWithInt:kCFNumberFloat64Type], [NSNumber numberWithInt:kCFNumberFloatType], [NSNumber numberWithInt:kCFNumberSInt8Type], [NSNumber numberWithInt:kCFNumberSInt16Type], [NSNumber numberWithInt:kCFNumberSInt32Type], [NSNumber numberWithInt:kCFNumberSInt64Type], [NSNumber numberWithInt:kCFNumberIntType], nil];
			if (![allowedTypes containsObject:[NSNumber numberWithInt:CFNumberGetType((CFNumberRef)rawValue)]]) { if (response) *response = CZAppPrefsKeyNotOfExpectedType; }
			else { if (response) *response = CZAppPrefsSuccessful; }
			CFNumberGetValue((CFNumberRef)rawValue, kCFNumberDoubleType, &result);
		}
		if (rawValue) CFRelease(rawValue);
	}
	else { if (response) *response = CZAppPrefsAppNotFound; }
	return result;
}
- (NSURL *)URLForKey:(NSString *)key {
	return [self URLForKey:key response:nil];
}
- (NSURL *)URLForKey:(NSString *)key response:(CZAppPrefsResponse *)response {
	NSURL *result = nil;
    if ([self appExists]) {
        CFTypeRef rawValue = CFPreferencesCopyValue((CFStringRef)key, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
        if (rawValue == NULL) { if (response) *response = CZAppPrefsKeyNotFound; } 
		else if (CFURLGetTypeID() == CFGetTypeID(rawValue)) {
            if (response) *response = CZAppPrefsSuccessful;
            result = [[(NSURL *)rawValue retain] autorelease];
        }
		else { if (response) *response = CZAppPrefsKeyNotOfExpectedType; }
		if (rawValue) CFRelease(rawValue);
    } 
	else { if (response) *response = CZAppPrefsAppNotFound; }
    return result;
}
#pragma mark Setters
- (void)setBool:(BOOL)value forKey:(NSString *)key {
	CFPreferencesSetValue((CFStringRef)key, (value ? kCFBooleanTrue : kCFBooleanFalse), (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
	CFPreferencesSynchronize((CFStringRef)bundleID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
}
- (void)setFloat:(float)value forKey:(NSString *)key {
	CFNumberRef floatValue = CFNumberCreate(kCFAllocatorDefault, kCFNumberFloatType, &value);
	CFPreferencesSetValue((CFStringRef)key, floatValue, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
	CFPreferencesSynchronize((CFStringRef)bundleID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (floatValue) CFRelease(floatValue);
}
- (void)setInteger:(int)value forKey:(NSString *)key {
	CFNumberRef intValue = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &value);
	CFPreferencesSetValue((CFStringRef)key, intValue, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
	CFPreferencesSynchronize((CFStringRef)bundleID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (intValue) CFRelease(intValue);
}
- (void)setObject:(id)value forKey:(NSString *)key {
	CFPreferencesSetValue((CFStringRef)key, (CFTypeRef)value, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
	CFPreferencesSynchronize((CFStringRef)bundleID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
}
- (void)setDouble:(double)value forKey:(NSString *)key {
	CFNumberRef doubleValue = CFNumberCreate(kCFAllocatorDefault, kCFNumberDoubleType, &value);
	CFPreferencesSetValue((CFStringRef)key, doubleValue, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
	CFPreferencesSynchronize((CFStringRef)bundleID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (doubleValue) CFRelease(doubleValue);
}
- (void)setURL:(NSURL *)value forKey:(NSString *)key {
	CFPreferencesSetValue((CFStringRef)key, (CFURLRef)value, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
	CFPreferencesSynchronize((CFStringRef)bundleID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);

}
- (void)removeObjectForKey:(NSString *)key {
	CFPreferencesSetValue((CFStringRef)key, NULL, (CFStringRef)bundleID, (global ? kCFPreferencesAnyUser : kCFPreferencesCurrentUser), kCFPreferencesAnyHost);
	CFPreferencesSynchronize((CFStringRef)bundleID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
}
#pragma mark Convenience Methods
- (BOOL)appExists {
	return ([[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:self.bundleID] ? YES : NO);
}
#pragma mark Properties
@synthesize global;
@synthesize bundleID;
@end