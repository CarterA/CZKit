//
//  CZLabel.m
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#if !TARGET_OS_IPHONE

#import "CZLabel.h"
#import <QuartzCore/QuartzCore.h>

@interface CZLabel () {
	CATextLayer *_textLayer;
	NSString *_text;
	NSFont *_font;
	CZColor *_textColor;
	CZColor *_shadowColor;
	CZColor *_highlightedTextColor;
	CGSize _shadowOffset;
	BOOL _highlighted;
	CZTextAlignment _textAlignment;
	CZLineBreakMode _lineBreakMode;
}
@end

@implementation CZLabel
@synthesize text=_text, font=_font, textColor=_textColor, shadowColor=_shadowColor, shadowOffset=_shadowOffset;
@synthesize textAlignment=_textAlignment, lineBreakMode=_lineBreakMode;
@synthesize highlighted=_highlighted, highlightedTextColor=_highlightedTextColor;

+ (Class)layerClass { return [CATextLayer class]; }

- (id)initWithFrame:(NSRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.textColor = [CZColor blackColor];
		self.font = [NSFont systemFontOfSize:17.0f];
		self.textAlignment = CZTextAlignmentLeft;
		self.lineBreakMode = CZLineBreakModeTailTruncation;
    }
	
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if((self = [super initWithCoder:aDecoder])) {
		self.textColor = [CZColor blackColor];
		self.font = [NSFont systemFontOfSize:17.0f];
		self.textAlignment = CZTextAlignmentLeft;
		self.lineBreakMode = CZLineBreakModeTailTruncation;
	}
	
	return self;
}

- (void)setText:(NSString *)text {
	[_text release];
	_text = [text copy];
	
	((CATextLayer*)self.layer).string = _text;
}

- (void)setFont:(NSFont *)font {
	[_font release];
	_font = [font retain];
	
	((CATextLayer*)self.layer).font = _font;
	((CATextLayer*)self.layer).fontSize = [_font pointSize];
}

- (void)setTextColor:(CZColor *)textColor {
	[_textColor release];
	_textColor = [textColor retain];
	
	if(![self isHighlighted]) {
		((CATextLayer*)self.layer).foregroundColor = _textColor.CGColor;
	}
}

- (void)setShadowColor:(CZColor *)shadowColor {
	[_shadowColor release];
	_shadowColor = [shadowColor retain];
	
	self.layer.shadowColor = _shadowColor.CGColor;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
	_shadowOffset = shadowOffset;
	
	self.layer.shadowOffset = _shadowOffset;
}

- (void)setTextAlignment:(CZTextAlignment)textAlignment {
	_textAlignment = textAlignment;
	
	NSString* alignmentMode = nil;
	switch(_textAlignment) {
		case CZTextAlignmentCenter:
			alignmentMode = kCAAlignmentCenter;
			break;
		case CZTextAlignmentRight:
			alignmentMode = kCAAlignmentRight;
			break;
		case CZTextAlignmentJusitifed:
			alignmentMode = kCAAlignmentJustified;
			break;
		case CZTextAlignmentNatural:
			alignmentMode = kCAAlignmentNatural;
			break;
		default:
			alignmentMode = kCAAlignmentLeft;
	}
	
	((CATextLayer*)self.layer).alignmentMode = alignmentMode;
}

- (void)setLineBreakMode:(CZLineBreakMode)lineBreakMode {
	_lineBreakMode = lineBreakMode;
	
	NSString* truncationMode = nil;
	
	switch(_lineBreakMode) {
		case CZLineBreakModeWordWrap:
		case CZLineBreakModeCharacterWrap:
			((CATextLayer*)self.layer).wrapped = YES;
			truncationMode = kCATruncationNone;
			break;
		case CZLineBreakModeClip:
			((CATextLayer*)self.layer).wrapped = NO;
			truncationMode = kCATruncationNone;
			break;
		case CZLineBreakModeHeadTruncation:
			truncationMode = kCATruncationStart;
			break;
		case CZLineBreakModeMiddleTruncation:
			truncationMode = kCATruncationMiddle;
			break;
		default:
			truncationMode = kCATruncationEnd;
	}
	
	((CATextLayer*)self.layer).truncationMode = truncationMode;
}

- (void)setHighlightedTextColor:(CZColor *)highlightedTextColor {
	[_highlightedTextColor release];
	_highlightedTextColor = [highlightedTextColor retain];
	
	if([self isHighlighted]) {
		((CATextLayer*)self.layer).foregroundColor = _highlightedTextColor.CGColor;
	}	
}

- (void)setHighlighted:(BOOL)highlighted {
	_highlighted = highlighted;
	
	if(_highlighted && self.highlighted) {
		((CATextLayer*)self.layer).foregroundColor = self.highlightedTextColor.CGColor;
	} else {
		((CATextLayer*)self.layer).foregroundColor = self.textColor.CGColor;
	}
}

- (void)dealloc {
	[_text release];
	[_font release];
	[_textColor release];
	[_shadowColor release];
    [super dealloc];
}

@end

#endif // !TARGET_OS_IPHONE