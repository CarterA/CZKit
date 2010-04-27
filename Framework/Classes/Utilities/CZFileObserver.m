//
//  CZFileObserver.m
//  CZKit
//
//  Created by Carter Allen on 12/31/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CZFileObserver.h"

static CZFileObserver *globalInstance;
@implementation CZFileObserver
- (id)init {
	if ((self = [super init])) {
		if (!globalInstance) {
			globalInstance = [self retain];
		}
	}
	return self;
}
+ (id)sharedObserver {
	id theInstance = globalInstance;
	if (!theInstance) 
		theInstance = [[[self alloc] init] autorelease];
	return theInstance;
}
@end