//
//  CZLabel.h
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZMacros.h"
#import "CZText.h"
#import "CZView.h"
#import "CZColor.h"

// TODO: Fix Shadows.  For some reason CATextLayer is ignoring it's shadow property

@class CATextLayer;
@interface CZLabel : CZView {}

@property(nonatomic,copy) NSString* text;
@property(nonatomic,retain) CZ_DYNAMIC_TYPE(NSFont, UIFont)* font;
@property(nonatomic,retain) CZColor* textColor;
@property(nonatomic,retain) CZColor* shadowColor;
@property(nonatomic,assign) CGSize shadowOffset;
@property(nonatomic,assign) CZTextAlignment textAlignment;
@property(nonatomic,assign) CZLineBreakMode lineBreakMode;

@property(nonatomic,retain) CZColor* highlightedTextColor;
@property(nonatomic,assign,getter=isHighlighted) BOOL highlighted;
@end