//
//  CZFileObserver.h
//  CZKit
//
//  Created by Carter Allen on 12/31/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#if !TARGET_OS_IPHONE

#import <Cocoa/Cocoa.h>

@interface CZFileObserver : NSObject {

}
+ (id)sharedObserver;
@end
#endif