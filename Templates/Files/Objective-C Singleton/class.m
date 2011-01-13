//
//  «FILENAME»
//  «PROJECTNAME»
//
//  Created by «FULLUSERNAME» on «DATE».
//  Copyright «YEAR» «ORGANIZATIONNAME». All rights reserved.
//

«OPTIONALHEADERIMPORTLINE»
@implementation «FILEBASENAMEASIDENTIFIER»
+ («FILEBASENAMEASIDENTIFIER» *)shared«FILEBASENAMEASIDENTIFIER» {
	static «FILEBASENAMEASIDENTIFIER» *global«FILEBASENAMEASIDENTIFIER»;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{ global«FILEBASENAMEASIDENTIFIER» = [[self alloc] init]; });
	return global«FILEBASENAMEASIDENTIFIER»;
}
@end