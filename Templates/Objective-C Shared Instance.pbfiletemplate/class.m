//
//  «FILENAME»
//  «PROJECTNAME»
//
//  Created by «FULLUSERNAME» on «DATE».
//  Copyright «YEAR» «ORGANIZATIONNAME». All rights reserved.
//

«OPTIONALHEADERIMPORTLINE»
static «FILEBASENAMEASIDENTIFIER» *global«FILEBASENAMEASIDENTIFIER»;
@implementation «FILEBASENAMEASIDENTIFIER»
+ («FILEBASENAMEASIDENTIFIER» *)shared«FILEBASENAMEASIDENTIFIER» {
	@synchronized(self) {
		if (!global«FILEBASENAMEASIDENTIFIER») global«FILEBASENAMEASIDENTIFIER» = [[self alloc] init];
		return global«FILEBASENAMEASIDENTIFIER»;
	}
}
+ (id)copyWithZone:(NSZone *)zone { return self; }
- (id)retain { return self; }
- (NSUInteger)retainCount { return NSUIntegerMax; }
- (void)release {}
- (id)autorelease { return self; }
@end