//
//  CZViewController.m
//  CZKit
//
//  Created by Carter Allen on 1/31/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZViewController.h"
#import "CZView.h"

@implementation CZViewController
@dynamic view;
- (CZView *)view { return super.view; }
- (void)setView:(CZView *)theView { [super setView:theView]; }
@end