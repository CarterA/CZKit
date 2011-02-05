//
//  CZIBViewController.m
//  CZKit
//
//  Created by Carter Allen on 2/1/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZIBViewController.h"
#import "CZViewControllerInspector.h"

@interface IBPlugin (UndocumentedGoodness)

@end

@interface CZIBViewController ()
@property (nonatomic, retain) NSView *cz_placeholderView;
@end

@implementation CZIBViewController
@synthesize cz_placeholderView;
- (NSView *)cz_placeholderView {
	if (!cz_placeholderView) cz_placeholderView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
	return cz_placeholderView;
}
- (void)ibPopulateAttributeInspectorClasses:(NSMutableArray *)classes {
    [super ibPopulateAttributeInspectorClasses:classes];
    [classes addObject:[CZViewControllerInspector class]];
}
- (BOOL)canEditInPersonalWindow { return YES; }
- (BOOL)mustEditInPersonalWindow { return YES; }
- (Class)ibEditorClass { return NSClassFromString(@"IBViewEditor"); }
- (Class)ibEditorViewClass { return NSClassFromString(@"IBViewEditorView"); }
- (id)editorWindowControllerForDocument:(NSDocument *)document {
	return [document documentWindowController];
}
- (id)ibDesignableContentView {
	return self.cz_placeholderView;
}

@end