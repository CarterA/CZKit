//
//  CZWindow.h
//  CZKit
//
//  Created by Carter Allen on 2/16/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZMacros.h"
#import "CZView.h"

@interface CZWindow : CZ_DYNAMIC_TYPE(CZView, UIWindow) {}
#if !TARGET_OS_IPHONE
- (void)makeKeyAndVisible;
- (void)sendEvent:(NSEvent *)event;
#endif
@end