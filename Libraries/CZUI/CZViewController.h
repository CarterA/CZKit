//
//  CZViewController.h
//  CZKit
//
//  Created by Carter Allen on 2/15/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZMacros.h"

@class CZView;

@interface CZViewController : CZ_DYNAMIC_TYPE(NSResponder, UIResponder) {}
- (void)loadView;
- (void)viewDidLoad;
@property (nonatomic, readonly) BOOL isViewLoaded;
@property (nonatomic, retain) CZView *view;
- (id)init; // It's like initWithNibName:, but without the nib support.
@end