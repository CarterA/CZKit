//
//  CZScroller.m
//  CZKit
//
//  Created by Carter Allen on 2/15/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZScroller.h"
#import "CZScrollView.h"
#import "CZGraphics.h"
#import "CZColor.h"

#if !TARGET_OS_IPHONE

@interface CZScrollView ()
- (void)_scrollerScrolled:(CZScroller *)scroller withEvent:(NSEvent *)event;
@end

@interface CZScroller ()
@property (nonatomic, assign) CZScrollView *scrollView;
@end

@implementation CZScroller
@synthesize scrollView=_scrollView;
- (id)initWithScrollView:(CZScrollView *)scrollView {
	if ((self = [super initWithFrame:CGRectZero])) {
		self.scrollView = scrollView;
		self.contentMode = CZViewContentModeRedraw;
	}
	return self;
}
- (void)drawRect:(CGRect)rect {
	CGContextRef context = CZGraphicsGetCurrentContext();
	[[CZColor colorWithWhite:0 alpha:0.5] set];
	CGContextBeginPath(context);
	cz_CGContextAddRoundedRect(context, CGRectInset(rect, 2, 2), (rect.size.width/2) - 2);
	CGContextFillPath(context);
}
- (void)mouseDragged:(NSEvent *)event {
	[self.scrollView _scrollerScrolled:self withEvent:event];
}
@end

#endif