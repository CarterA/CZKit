//
//  CZKit.h
//  CZKit
//
//  Created by Carter Allen on 12/9/09.
//  Copyright 2009 Carter Allen. All rights reserved.
//

#ifdef __OBJC__
	#import <Foundation/Foundation.h>
	#import <QuartzCore/QuartzCore.h>
	#if	TARGET_OS_IPHONE
		#import <UIKit/UIKit.h>
		#import <CoreGraphics/CoreGraphics.h>
	#else
		#import <AppKit/AppKit.h>
	#endif
#endif

#import "CZCore.h"
#import "CZCategories.h"
#import "CZUtilities.h"
#import "CZUI.h"