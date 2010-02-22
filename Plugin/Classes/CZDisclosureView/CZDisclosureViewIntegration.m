//
//  CZDisclosureViewIntegration.m
//  CZKit
//
//  Created by Carter Allen on 2/9/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import <CZKit/CZKit.h>
#import "CZDisclosureViewInspector.h"
#import "CZCustomView.h"
#import "CZDisclosureViewHeader.h"

#define CZDisclosureViewDefaultHiddenHeight 20.0

@interface NSView (UndocumentedIBAdditions)
- (BOOL)editorHandlesCaches;
@end

@implementation CZDisclosureView (CZDisclosureViewIntegration)
- (void)ibPopulateKeyPaths:(NSMutableDictionary *)keyPaths {
    [super ibPopulateKeyPaths:keyPaths];
    [[keyPaths objectForKey:IBAttributeKeyPaths] addObjectsFromArray:[NSArray arrayWithObjects:nil]];
}
- (void)ibPopulateAttributeInspectorClasses:(NSMutableArray *)classes {
    [super ibPopulateAttributeInspectorClasses:classes];
    [classes addObject:[CZDisclosureViewInspector class]];
}
- (id)initWithCoder:(NSCoder *)coder {
	if (!(self = [super initWithCoder:coder])) return nil;
	if ([coder allowsKeyedCoding]) {
		if ([coder containsValueForKey:@"_hiddenWindowSize"]) _hiddenWindowSize = [coder decodeSizeForKey:@"_hiddenWindowSize"];
		if ([coder containsValueForKey:@"_expandedWindowSize"]) _expandedWindowSize = [coder decodeSizeForKey:@"_expandedWindowSize"];
		if ([coder containsValueForKey:@"isOpen"]) isOpen = [coder decodeBoolForKey:@"isOpen"];
		if ([coder containsValueForKey:@"title"]) title = [coder decodeObjectForKey:@"title"];
	}
	NSRect frame = self.bounds;
	headerView = [[CZDisclosureViewHeader alloc] initWithFrame:NSMakeRect(frame.origin.x, frame.origin.y + frame.size.height - CZDisclosureViewDefaultHiddenHeight, frame.size.width, CZDisclosureViewDefaultHiddenHeight)];
	[(CZDisclosureViewHeader *)headerView setParent:self];
	NSUInteger headerMask = NSViewWidthSizable | NSViewMinYMargin;
	[headerView setAutoresizingMask:headerMask];
	contentView = [[CZCustomView alloc] initWithFrame:NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - headerView.frame.size.height)];
	NSUInteger contentMask = NSViewWidthSizable | NSViewHeightSizable | NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin;
	[contentView setAutoresizingMask:contentMask];
	[self addSubview:contentView];
	[self addSubview:headerView];
	[self setNeedsDisplay:YES];
	return self;
}
- (NSView *)ibDesignableContentView {
	return contentView;
}
- (BOOL)canEditInPersonalWindow { return YES; }
- (BOOL)ibIsContainer { return YES; }
- (BOOL)ibShouldShowContainerGuides { return NO; }
- (BOOL)ibDrawFrameWhileResizing { return YES; }
- (id)ibNearestTargetForDrag { return contentView; }
- (BOOL)canEditSelf { return YES; }
- (BOOL)editorHandlesCaches { return YES; }
@end