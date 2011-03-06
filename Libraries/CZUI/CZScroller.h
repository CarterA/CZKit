//
//  CZScroller.h
//  CZKit
//
//  Created by Carter Allen on 2/15/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#if !TARGET_OS_IPHONE

#import "CZView.h"

@class CZScrollView;

@interface CZScroller : CZView {}
- (id)initWithScrollView:(CZScrollView *)scrollView;
@end

#endif