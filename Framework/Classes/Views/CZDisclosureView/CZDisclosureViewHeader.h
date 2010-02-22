//
//  CZDisclosureViewHeader.h
//  CZKit
//
//  Created by Carter Allen on 2/9/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CZDisclosureView.h"
#import "CZInsetTextField.h"

@interface CZDisclosureViewHeader : NSView {
	IBOutlet CZDisclosureView *parent;
	BOOL _clicked;
	CZInsetTextField *_titleField;
}
@property (nonatomic, assign) IBOutlet CZDisclosureView *parent;
@end