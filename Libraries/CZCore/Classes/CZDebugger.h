//
//  CZDebugger.h
//  CZKit
//
//  Created by Carter Allen on 8/7/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#define CZLog(arguments, ...) NSLog(@"%s(%d): " arguments, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define CZLogMethodName() NSLog(@"%s", __PRETTY_FUNCTION__)
#define CZAssert(statement) if (!(statement)) NSLog(@"CZAssert failed on line %d in method %s.", __LINE__, __PRETTY_FUNCTION__)

@interface CZDebugger : NSObject
#if !TARGET_OS_IPHONE
+ (BOOL)debuggerIsAttached;
#endif
@end
