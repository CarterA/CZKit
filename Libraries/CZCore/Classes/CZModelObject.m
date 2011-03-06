//
//  CZModelObject.m
//  CZKit
//
//  Created by Carter Allen on 2/5/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

/* Just a quick note here...
 
 This has been done to death. Really. There are tons of
 model object classes out there. There is only one that I've
 found that actually uses new runtime features instead of
 doing a lot of unnecessary work though, and that is...
 SMModelObject: https://github.com/nfarina/modelobject
 This class borrows a lot from SMModelObject. Unfortunately,
 it suffers from Not-Invented-Here syndrome, and I really don't
 like dependencies. That, and I had a few things I wanted to
 change. Anyways, if this doesn't work, use SMModelObject. It
 works, and is probably better. And if the coder of SMModelObject
 reads this, please don't be mad. I really love your work. I
 just love my own work more. Cheers.
 
 */
#if !TARGET_OS_IPHONE
#import "CZModelObject.h"
#import <objc/runtime.h> // Whenever I import this header, I know
						 // that there's going to be fun ahead.

static NSMutableDictionary *cz_ivarNames = nil;

@implementation CZModelObject

+ (NSArray *)ivarNames {
	return [cz_ivarNames objectForKey:[self class]];
}
+ (void)initialize {
	
	// Kids, if you see this method declaration and think "Hey,
	// I should put my initializing code in that method too"...
	//
	//
	// STOP.
	//
	//
	// Do I have your attention? Yeah, don't do that. +initialize
	// is a bad place to place initialization code, unless you
	// know what you're doing. Like I do.
	//
	// Do as I say, not as I do.
	
	// We need to cache all of the runtimey-data like properties
	// in an easy-to-access, enumerable object. Like a dictionary.
	
	if (!cz_ivarNames) cz_ivarNames = [[NSMutableDictionary alloc] init];
	
	NSMutableArray *ivarNames = [NSMutableArray array];
		
	for (Class class = self; class != [CZModelObject class]; class = [class superclass]) {
		
		unsigned int numberOfIvars;
		Ivar *ivars = class_copyIvarList(class, &numberOfIvars);
		for (NSInteger i = 0; i < numberOfIvars; i++) {
			Ivar ivar = ivars[i];
			NSString *name = [[NSString alloc] initWithUTF8String:ivar_getName(ivar)];
			[ivarNames addObject:name];
			[name release];
		}
		free(ivars);
		
	}
	
	[cz_ivarNames setObject:ivarNames forKey:self];
	
	// I know it's a mess, but hey, you still love me. Right? Right?
	
}

#pragma mark -
#pragma mark Encoding and Decoding
- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		for (NSString *ivarName in [cz_ivarNames objectForKey:[self class]]) {
			
			Ivar ivar = class_getInstanceVariable([self class], [ivarName UTF8String]);
			const char *typeEncoding = ivar_getTypeEncoding(ivar);
			int type = typeEncoding[0];
			switch (type) {
				case _C_STRUCT_B:
					//if (strcmp(typeEncoding, @encode(CGRect)) || strcmp(typeEncoding, @encode(NSRect))) [self setValue:[NSValue valueWithRect:[decoder decodeRectForKey:ivarName]] forKey:ivarName];
					break;
				default:
					[self setValue:[decoder decodeObjectForKey:ivarName] forKey:ivarName];
					break;
			}
			
		}
	}
	return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
	for (NSString *ivarName in [cz_ivarNames objectForKey:[self class]]) {
		
		Ivar ivar = class_getInstanceVariable([self class], [ivarName UTF8String]);
		const char *typeEncoding = ivar_getTypeEncoding(ivar);
		int type = typeEncoding[0];
		NSLog(@"ivarName: %@, type: %c, full encoding: %s", ivarName, type, typeEncoding);
		switch (type) {
			case _C_STRUCT_B:
				NSLog(@"ivarName: %@, valueForKey: %@", ivarName, [self valueForKey:ivarName]);
				if (strcmp(typeEncoding, @encode(CGRect)) || strcmp(typeEncoding, @encode(NSRect))) [encoder encodeRect:[[self valueForKey:ivarName] rectValue]];
				break;
			default:
				[encoder encodeObject:[self valueForKey:ivarName] forKey:ivarName];
				break;
		}
		
	}
}

- (void)dealloc {
    [super dealloc];
}

@end
#endif