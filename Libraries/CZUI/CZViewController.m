//
//  CZViewController.m
//  CZKit
//
//  Created by Carter Allen on 2/15/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#if !TARGET_OS_IPHONE

#import "CZViewController.h"
#import "CZView.h"
#import "CZView-Private.h"

@implementation CZViewController
@synthesize view=_view;
- (id)init {
	if ((self = [super init])) {
		
	}
	return self;
}

- (void)dealloc {
	_view.viewDelegate = nil;
    [_view release];
    [super dealloc];
}

- (BOOL)isViewLoaded { return (_view != nil); }

- (void)loadView { self.view = [[[CZView alloc] initWithFrame:CGRectZero] autorelease]; }

- (void)viewDidLoad {}

- (CZView *)view {
	if (!self.isViewLoaded) {
		[self loadView];
		[self viewDidLoad];
	}
	return [[_view retain] autorelease];
}

- (void)setView:(CZView *)newView {
	if (newView == _view) return;
	_view.viewDelegate = nil;
	[_view release];
	_view = [newView retain];
	_view.viewDelegate = self;
	[self setNextResponder:_view.superview];
}
@end

#endif // !TARGET_OS_IPHONE