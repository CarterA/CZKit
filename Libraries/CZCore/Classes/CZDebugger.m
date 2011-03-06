//
//  CZDebugger.m
//  CZKit
//
//  Created by Carter Allen on 8/7/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "CZDebugger.h"

#include <assert.h>
#include <stdbool.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>

@implementation CZDebugger
#if !TARGET_OS_IPHONE
+ (BOOL)debuggerIsAttached {
	int junk;
	int mib[4];
    struct kinfo_proc info;
    size_t size;
	info.kp_proc.p_flag = 0;
	mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_PID;
    mib[3] = getpid();
	size = sizeof(info);
    junk = sysctl(mib, sizeof(mib) / sizeof(*mib), &info, &size, NULL, 0);
    assert(junk == 0);
	return ((info.kp_proc.p_flag & P_TRACED) != 0);
}
#endif
@end