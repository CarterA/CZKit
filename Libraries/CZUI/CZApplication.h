//
//  CZApplication.h
//  CZKit
//
//  Created by Carter Allen on 2/20/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#if TARGET_OS_IPHONE
	#define CZApplicationMain(argumentCount, arguments, principalClass, appDelegate) \
	UIApplicationMain(argumentCount, arguments, principalClass, appDelegate)
#else
	#define CZApplicationMain(argumentCount, arguments, principalClass, appDelegate) \
	NSApplicationMain(argumentCount, (const char **)arguments)
#endif