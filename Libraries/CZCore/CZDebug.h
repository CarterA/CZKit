//
//  CZDebug.h
//  CZKit
//
//  Created by Carter Allen on 8/7/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#define CZLogMethodName() NSLog(@"%s", __PRETTY_FUNCTION__)
#define CZAssert(statement) if (!(statement)) NSLog(@"CZAssert failed on line %d in method ", __LINE__, __PRETTY_FUNCTION__)