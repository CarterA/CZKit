//
//  CZTableViewCell.h
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZView.h"
#import "CZMacros.h"

@class CZColor, CZLabel, CZImageView, CZButton, CZTextField;

#if TARGET_OS_IPHONE

typedef UITableViewCellStyle CZTableViewCellStyle;
enum {
    CZTableViewCellStyleDefault = UITableViewCellStyleDefault,
    CZTableViewCellStyleValue1 = UITableViewCellStyleDefault,
    CZTableViewCellStyleValue2 = UITableViewCellStyleDefault,
    CZTableViewCellStyleSubtitle = UITableViewCellStyleDefault
};

typedef UITableViewCellSeparatorStyle CZTableViewCellSeparatorStyle;
enum {
    CZTableViewCellSeparatorStyleNone = UITableViewCellSeparatorStyleNone,
    CZTableViewCellSeparatorStyleSingleLine = UITableViewCellSeparatorStyleSingleLine
};

typedef UITableViewCellSelectionStyle CZTableViewCellSelectionStyle;
enum {
    CZTableViewCellSelectionStyleNone = UITableViewCellSelectionStyleNone,
    CZTableViewCellSelectionStyleBlue = UITableViewCellSelectionStyleBlue,
    CZTableViewCellSelectionStyleGray = UITableViewCellSelectionStyleGray
};

typedef UITableViewCellEditingStyle CZTableViewCellEditingStyle;
enum {
    CZTableViewCellEditingStyleNone = UITableViewCellEditingStyleNone,
    CZTableViewCellEditingStyleDelete = UITableViewCellEditingStyleDelete,
    CZTableViewCellEditingStyleInsert = UITableViewCellEditingStyleInsert
};

typedef UITableViewCellAccessoryType CZTableViewCellAccessoryType;
enum {
    CZTableViewCellAccessoryNone = UITableViewCellAccessoryNone,
    CZTableViewCellAccessoryDisclosureIndicator = UITableViewCellAccessoryDisclosureIndicator,
    CZTableViewCellAccessoryDetailDisclosureButton = UITableViewCellAccessoryDetailDisclosureButton,
    CZTableViewCellAccessoryCheckmark = UITableViewCellAccessoryCheckmark
};

enum {
    CZTableViewCellStateDefaultMask = UITableViewCellStateDefaultMask,
    CZTableViewCellStateShowingEditControlMask = UITableViewCellStateShowingEditControlMask,
    CZTableViewCellStateShowingDeleteConfirmationMask = UITableViewCellStateShowingDeleteConfirmationMask
};
typedef UITableViewCellStateMask CZTableViewCellStateMask;

#else

typedef enum {
    CZTableViewCellStyleDefault,	// Simple cell with text label and optional image view (behavior of CZTableViewCell in iPhoneOS 2.x)
    CZTableViewCellStyleValue1,		// Left aligned label on left and right aligned label on right with blue text (Used in Settings)
    CZTableViewCellStyleValue2,		// Right aligned label on left with blue text and left aligned label on right (Used in Phone/Contacts)
    CZTableViewCellStyleSubtitle	// Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).
} CZTableViewCellStyle;

typedef enum {
    CZTableViewCellSeparatorStyleNone,
    CZTableViewCellSeparatorStyleSingleLine
} CZTableViewCellSeparatorStyle;

typedef enum {
    CZTableViewCellSelectionStyleNone,
    CZTableViewCellSelectionStyleBlue,
    CZTableViewCellSelectionStyleGray
} CZTableViewCellSelectionStyle;

typedef enum {
    CZTableViewCellEditingStyleNone,
    CZTableViewCellEditingStyleDelete,
    CZTableViewCellEditingStyleInsert
} CZTableViewCellEditingStyle;

typedef enum {
    CZTableViewCellAccessoryNone,                   // don't show any accessory view
    CZTableViewCellAccessoryDisclosureIndicator,    // regular chevron. doesn't track
    CZTableViewCellAccessoryDetailDisclosureButton, // blue button w/ chevron. tracks
    CZTableViewCellAccessoryCheckmark               // checkmark. doesn't track
} CZTableViewCellAccessoryType;

enum {
    CZTableViewCellStateDefaultMask                     = 0,
    CZTableViewCellStateShowingEditControlMask          = 1 << 0,
    CZTableViewCellStateShowingDeleteConfirmationMask   = 1 << 1
};
typedef NSUInteger CZTableViewCellStateMask;        // available in iPhone 3.0

#endif

#define CZTableViewCellStateEditingMask CZTableViewCellStateShowingEditControlMask

CZKIT_EXTERN_CLASS @interface CZTableViewCell : CZ_DYNAMIC_TYPE(CZView, UITableViewCell) {}

#if !TARGET_OS_IPHONE

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithStyle:(CZTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

// Content.  These properties provide direct access to the internal label and image views used by the table view cell.  These should be used instead of the content properties below.
@property(nonatomic,readonly,retain) CZImageView  *imageView;   // default is nil.  image view will be created if necessary.

@property(nonatomic,readonly,retain) CZLabel      *textLabel;   // default is nil.  label will be created if necessary.
@property(nonatomic,readonly,retain) CZLabel      *detailTextLabel;   // default is nil.  label will be created if necessary (and the current style supports a detail label).

// If you want to customize cells by simply adding additional views, you should add them to the content view so they will be positioned appropriately as the cell transitions into and out of editing mode.
@property(nonatomic,readonly,retain) CZView       *contentView;

// Default is nil for cells in CZTableViewStylePlain, and non-nil for CZTableViewStyleGrouped. The 'backgroundView' will be added as a subview behind all other views.
@property(nonatomic,retain) CZView                *backgroundView;

// Default is nil for cells in CZTableViewStylePlain, and non-nil for CZTableViewStyleGrouped. The 'selectedBackgroundView' will be added as a subview directly above the backgroundView if not nil, or behind all other views. It is added as a subview only when the cell is selected. Calling -setSelected:animated: will cause the 'selectedBackgroundView' to animate in and out with an alpha fade.
@property(nonatomic,retain) CZView                *selectedBackgroundView;

@property(nonatomic,readonly,copy) NSString       *reuseIdentifier;
- (void)prepareForReuse;                                                        // if the cell is reusable (has a reuse identifier), this is called just before the cell is returned from the table view method dequeueReusableCellWithIdentifier:.  If you override, you MUST call super.

@property(nonatomic) CZTableViewCellSelectionStyle  selectionStyle;             // default is CZTableViewCellSelectionStyleBlue.
@property(nonatomic,getter=isSelected) BOOL         selected;                   // set selected state (title, image, background). default is NO. animated is NO
@property(nonatomic,getter=isHighlighted) BOOL      highlighted;                // set highlighted state (title, image, background). default is NO. animated is NO
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;                     // animate between regular and selected state
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;               // animate between regular and highlighted state

@property(nonatomic,readonly) CZTableViewCellEditingStyle editingStyle;         // default is CZTableViewCellEditingStyleNone. This is set by CZTableView using the delegate's value for cells who customize their appearance accordingly.
@property(nonatomic) BOOL                           showsReorderControl;        // default is NO
@property(nonatomic) BOOL                           shouldIndentWhileEditing;   // default is YES.  This is unrelated to the indentation level below.

@property(nonatomic) CZTableViewCellAccessoryType   accessoryType;              // default is CZTableViewCellAccessoryNone. use to set standard type
@property(nonatomic,retain) CZView                 *accessoryView;              // if set, use custom view. ignore accessoryType. tracks if enabled can calls accessory action
@property(nonatomic) CZTableViewCellAccessoryType   editingAccessoryType;       // default is CZTableViewCellAccessoryNone. use to set standard type
@property(nonatomic,retain) CZView                 *editingAccessoryView;       // if set, use custom view. ignore editingAccessoryType. tracks if enabled can calls accessory action

@property(nonatomic) NSInteger                      indentationLevel;           // adjust content indent. default is 0
@property(nonatomic) CGFloat                        indentationWidth;           // width for each level. default is 10.0

@property(nonatomic,getter=isEditing) BOOL          editing;                    // show appropriate edit controls (+/- & reorder). By default -setEditing: calls setEditing:animated: with NO for animated.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@property(nonatomic,readonly) BOOL                  showingDeleteConfirmation;  // currently showing "Delete" button

#endif

@end