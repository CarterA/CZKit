//
//  CZView-Private.h
//  CZKit
//
//  Created by Carter Allen on 2/15/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

@class CZView;
@class CZViewController;

@interface CZView ()
#if !TARGET_OS_IPHONE
@property (nonatomic, assign) CZViewController *viewDelegate;
- (void)_updateNextResponder;
#endif
@end