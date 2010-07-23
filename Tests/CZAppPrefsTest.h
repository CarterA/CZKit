//
//  CZAppPrefsTest.h
//  CZKit
//
//  Created by Carter Allen on 12/28/09.
//  Copyright 2009 Carter Allen. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <CZKit/CZKit.h>

@interface CZAppPrefsTest : SenTestCase {
	CZAppPrefs *appPrefs;
	CZAppPrefs *nonExistentAppPrefs;
	CZAppPrefsResponse response;
}
@end