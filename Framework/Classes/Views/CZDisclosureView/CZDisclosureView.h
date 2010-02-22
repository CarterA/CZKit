//
//  CZDisclosureView.h
//  CZKit
//
//	Much of the code in this class and associated classes
//	is based on SNDisclosableView, which hasn't been
//	updated in a long time.
//
//  Created by Carter Allen on 2/9/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CZDisclosureView : NSView {
	BOOL isOpen;
	NSString *title;
	NSView *contentView;
	NSView *headerView;
	NSArray *hiddenSubviews;
	NSSize _hiddenViewSize;
	NSSize _expandedViewSize;
	NSSize _hiddenWindowSize;
	NSSize _expandedWindowSize;
	NSView *_originalNextKeyView;
    NSView *_lastChildKeyView;
}
- (IBAction)toggle:(id)sender;
- (IBAction)open:(id)sender;
- (IBAction)close:(id)sender;
@property (getter=isOpen, setter=setIsOpen:) BOOL isOpen;
@property (nonatomic, copy) NSString *title;
@end