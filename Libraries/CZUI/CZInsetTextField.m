//
//  CZInsetTextField.m
//  CZKit
//
//  Created by Carter Allen on 2/8/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

#import "CZInsetTextField.h"

@implementation CZInsetTextField
- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) [[self cell] setBackgroundStyle:NSBackgroundStyleRaised];
	return self;
}
@end