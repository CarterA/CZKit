//
//  CZDebuggerTest.m
//  CZKit
//
//  Created by Carter Allen on 8/7/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "CZDebuggerTest.h"

@implementation CZDebuggerTest
- (void)testDebuggerCheck {
	STAssertFalse([CZDebugger debuggerIsAttached], @"CZDebugger's debugger check is broken (or this test is being run with a debugger attached.");
}
@end