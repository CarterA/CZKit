//
//  CZScrollView.m
//  CZKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "CZScrollView.h"
#import "CZColor.h"
#import "CZScroller.h"
#import "CZView.h"

#import <QuartzCore/QuartzCore.h>

#if !TARGET_OS_IPHONE

@interface CZScrollView ()
@property (nonatomic, readwrite, retain) CZView *contentView;
@property (nonatomic, retain) CZScroller *scroller;
@end

#endif

@implementation CZScrollView
#if !TARGET_OS_IPHONE
@synthesize contentView=_contentView;
@synthesize delegate=_delegate;
@synthesize scroller=_scroller;
@synthesize contentSize=_contentSize;
@synthesize contentOffset=_contentOffset;

- (id)initWithFrame:(CGRect)frameRect {
	self = [super initWithFrame:frameRect];
	if (!self) return nil;
	
	self.contentView = [[CZView alloc] initWithFrame:self.bounds];
	self.contentView.autoresizingMask = 0;
	self.contentView.backgroundColor = [CZColor grayColor];
	[super addSubview:self.contentView];
	
	self.scroller = [[CZScroller alloc] initWithScrollView:self];
	[super addSubview:self.scroller];
	
	return self;
}

- (void)dealloc {
	[_contentView release];
	[_scroller release];
	[super dealloc];
}

- (CGRect)scrollerFrame {
	CGRect bounds = self.bounds;
	return (CGRect) {
		.origin.x = bounds.size.width - 14,
		.origin.y = 5,
		.size.height = bounds.size.height - 10,
		.size.width = 14,
	};
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	CGPoint contentOffset = self.contentOffset;
	contentOffset.x = fminf(contentOffset.x, fmaxf(0.0f, self.contentSize.width - self.bounds.size.width));
	contentOffset.y = fminf(contentOffset.y, fmaxf(0.0f, self.contentSize.height - self.bounds.size.height));
	self.contentOffset = contentOffset;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGRect availableFrame = [self scrollerFrame];
	CGRect bounds = self.bounds;
	
	const CGFloat minimumScrollerSize = 20;
	
	CGPoint maximumContentOffset = (CGPoint) {
		.x = fmaxf(self.contentSize.width - bounds.size.width, 0),
		.y = fmaxf(self.contentSize.height - bounds.size.height, 0),
	};
	
	BOOL showVerticalScroller = self.contentSize.height > 0 && bounds.size.height < self.contentSize.height;
	
	
	if (showVerticalScroller) {
		CGFloat verticalScrollerSize = availableFrame.size.height * bounds.size.height / self.contentSize.height;
		
		verticalScrollerSize = fminf(fmaxf(minimumScrollerSize, verticalScrollerSize), availableFrame.size.height);
		
		CGRect scrollerFrame =  {
			.origin.x = availableFrame.origin.x,
			.origin.y = availableFrame.origin.y + (availableFrame.size.height - verticalScrollerSize) * (self.contentOffset.y / maximumContentOffset.y),
			.size.width = availableFrame.size.width,
			.size.height = verticalScrollerSize,
		};
		
		//Fix scroller going off the end
		if (scrollerFrame.origin.y + scrollerFrame.size.height > CGRectGetMaxY(availableFrame)) {
			scrollerFrame.origin.y = CGRectGetMaxY(availableFrame) - scrollerFrame.size.height;
		}
		self.scroller.frame = scrollerFrame;
		self.scroller.alpha = 1;
	}
	else {
		self.scroller.frame = availableFrame;
		self.scroller.alpha = 0;
	}
	
	self.contentView.frame = (CGRect) {
		.origin.x = 0,
		.origin.y = 0,
		.size.width = fmaxf(self.contentSize.width, bounds.size.width),
		.size.height = fmaxf(self.contentSize.height, bounds.size.height),
		
	};
	
	self.contentView.bounds = (CGRect) {
		.origin.x = self.contentOffset.x,
		.origin.y = self.contentOffset.y,
		.size.width = fmaxf(_contentSize.width, bounds.size.width),
		.size.height = fmaxf(_contentSize.height, bounds.size.height),
	};
	
}

- (void)scrollWheel:(NSEvent *)inEvent {
	CGPoint contentOffset = self.contentOffset;
	contentOffset.y -= 8.0f * [inEvent deltaY];
	contentOffset.y = floorf(fmaxf(0.0f, fminf(contentOffset.y, self.contentSize.height - self.frame.size.height)));
	self.contentOffset = contentOffset;
}

- (void)setContentSize:(CGSize)size {
	_contentSize = size;
	[self setNeedsLayout];
}

- (void)setContentOffset:(CGPoint)point {
	_contentOffset = point;
	[self setNeedsLayout];
}

- (void)addSubview:(CZView*)aView { [self.contentView addSubview:aView]; }

- (void)_scrollerScrolled:(CZScroller *)scroller withEvent:(NSEvent *)event {
	//dy is backwards because of coordinate flipping. Do we care?
	CGFloat dy = -[event deltaY];
	CGRect scrollerRect = [self scrollerFrame];
	CGPoint contentOffset = self.contentOffset;
	contentOffset.y -= (dy / scrollerRect.size.height) * self.contentSize.height;
	contentOffset.y = floorf(fmaxf(0.0f, fminf(contentOffset.y, self.contentSize.height - self.frame.size.height)));
	self.contentOffset = contentOffset;
}

#endif // !TARGET_OS_IPHONE

@end