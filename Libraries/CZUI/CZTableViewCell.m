//
//  CZTableViewCell.m
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZTableViewCell.h"
#import "CZColor.h"
#import "CZLabel.h"

@interface CZTableViewCell ()
#if !TARGET_OS_IPHONE
{
	id           _layoutManager;
    id           _target;
    SEL          _editAction;
    SEL          _accessoryAction;
    id           _oldEditingData;
    id           _editingData;
    CGFloat      _rightMargin;
    NSInteger    _indentationLevel;
    CGFloat      _indentationWidth;
    NSString    *_reuseIdentifier;
    CZView      *_contentView;
    CZImageView *_imageView;
    CZLabel     *_textLabel;
    CZLabel     *_detailTextLabel;
    CZView      *_backgroundView;
    CZView      *_selectedBackgroundView;
    CZView      *_selectedOverlayView;
    CZColor     *_separatorColor;
    CZView      *_floatingSeparatorView;
    CFMutableDictionaryRef _unhighlightedStates;
    struct {
        unsigned int separatorStyle:3;
        unsigned int selectionFadeFraction:11;	// used to indicate selection
        unsigned int editingStyle:3;
        unsigned int showsAccessoryWhenEditing:1;
        unsigned int showDisclosure:1;
        unsigned int showTopSeparator:1;
		
        unsigned int disclosureClickable:1;
        unsigned int disclosureStyle:1;
        unsigned int showingRemoveControl:1;
        unsigned int sectionLocation:3;
        unsigned int tableViewStyle:1;
        unsigned int fontSet:1;
        unsigned int usingDefaultSelectedBackgroundView:1;
        unsigned int wasSwiped:1;
        unsigned int highlighted:1;
        unsigned int separatorDirty:1;
        unsigned int drawn:1;
        unsigned int drawingDisabled:1;
        unsigned int style:12;
    } _tableCellFlags;
    
    CZView *_accessoryView;
    CZView *_editingAccessoryView;
    CZView *_customAccessoryView;
    CZView *_customEditingAccessoryView;
    CZView *_separatorView;
    CZView *_topSeparatorView;
    CZTextField *_editableTextField;
    CFAbsoluteTime _lastSelectionTime;
    NSTimer *_deselectTimer;
    CGFloat _textFieldOffset;
    SEL _returnAction;
	CZTableViewCellSelectionStyle  _selectionStyle;
	BOOL _isSelected;
	BOOL _isHighlighted;
	CZTableViewCellEditingStyle _editingStyle;
	BOOL _showsReorderControl;
	BOOL _shouldIndentWhileEditing;
	BOOL _editing;
	BOOL _showingDeleteConfirmation;
	CZTableViewCellAccessoryType   _accessoryType;
	CZTableViewCellAccessoryType   _editingAccessoryType;
}
#endif
@end

@implementation CZTableViewCell
#if !TARGET_OS_IPHONE
@synthesize imageView=_imageView, textLabel=_textLabel, detailTextLabel=_detailTextLabel;
@synthesize contentView=_contentView, backgroundView=_backgroundView, selectedBackgroundView=_selectedBackgroundView;
@synthesize reuseIdentifier=_reuseIdentifier, selectionStyle=_selectionStyle, selected=_isSelected;
@synthesize highlighted=_isHighlighted, editingStyle=_editingStyle, showsReorderControl=_showsReorderControl;
@synthesize shouldIndentWhileEditing=_shouldIndentWhileEditing, accessoryType=_accessoryType;
@synthesize accessoryView=_accessoryView, editingAccessoryView=_editingAccessoryView;
@synthesize editingAccessoryType=_editingAccessoryType, indentationLevel=_indentationLevel;
@synthesize indentationWidth=_indentationWidth, editing=_editing, showingDeleteConfirmation=_showingDeleteConfirmation;

- (id)initWithFrame:(NSRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if((self = [super initWithFrame:frame])) {
		self.autoresizingMask = CZViewAutoresizingFlexibleWidth;
		self.backgroundColor = [CZColor whiteColor];
		_reuseIdentifier = [reuseIdentifier copy];
		_selectionStyle = CZTableViewCellSelectionStyleBlue;
		
		_contentView = [[CZView alloc] initWithFrame:NSMakeRect(0.0f, 0.0f, frame.size.width, frame.size.height-1.0f)];
		_contentView.autoresizingMask = CZViewAutoresizingFlexibleWidth | CZViewAutoresizingFlexibleHeight;
		
		_separatorView = [[CZView alloc] initWithFrame:NSMakeRect(0.0f, frame.size.height - 1.0f, frame.size.width, 1.0f)];
		_separatorView.autoresizingMask = CZViewAutoresizingFlexibleWidth | CZViewAutoresizingFlexibleHeight;
		
		[_contentView addSubview:_separatorView];
		
		[self addSubview:_contentView];
		//[self addSubview:_separatorView];
		
		_separatorView.backgroundColor = [CZColor blackColor];
	}
	
	return self;
}

- (id)initWithStyle:(CZTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [self initWithFrame:NSMakeRect(0.0f, 0.0f, 320.0f, 44.0f) reuseIdentifier:reuseIdentifier])) {
		
	}
	return self;
}

- (CZLabel *)textLabel {
	@synchronized(self) {
		if(!_textLabel) {
			_textLabel = [[CZLabel alloc] initWithFrame:_contentView.bounds];
			_textLabel.autoresizingMask = CZViewAutoresizingFlexibleWidth | CZViewAutoresizingFlexibleHeight;
			_textLabel.font = [NSFont boldSystemFontOfSize:17.0f];
			_textLabel.backgroundColor = self.backgroundColor;
			_textLabel.textColor = [CZColor blackColor];
			
			[_contentView addSubview:_textLabel];
		}
	}
	
	return _textLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	self.selected = selected;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	self.highlighted = highlighted;
	
	if(_textLabel) {
		[_textLabel setHighlighted:highlighted];
	}
	
	[_contentView setOpaque:!highlighted];
	
	[self setNeedsDisplay];
}

- (void)drawRect:(NSRect)rect {
	NSGradient *grad = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceRed:5/255 green:140/255 blue:245/255 alpha:1.0] endingColor:[NSColor colorWithDeviceRed:1/255 green:93/255 blue:230/255 alpha:1.0]];
	[grad drawInRect:rect angle:90];
	[grad release];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	self.editing = editing;
}

- (void)prepareForReuse {
	
}

- (CZColor*)separatorColor {
	return _separatorColor;
}

- (void)setSeparatorColor:(CZColor*)aColor {
	[_separatorColor release];
	_separatorColor = [aColor retain];
	_separatorView.backgroundColor = _separatorColor;
}

- (void)layoutSubviews {
	[super layoutSubviews];
}

- (void)mouseDown:(NSEvent *)theEvent {
	[self setHighlighted:YES];
}

- (void)mouseUp:(NSEvent *)theEvent {
	[self setHighlighted:NO animated:YES];
}

- (void)dealloc {
	[_separatorColor release];
	[_contentView release];
	[super dealloc];
}
#endif // !TARGET_OS_IPHONE
@end