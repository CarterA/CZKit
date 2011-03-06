//
//  CZTableView.h
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZMacros.h"
#import "CZView.h"
#import "CZScrollView.h"
#import "CZTableViewCell.h"

#if TARGET_OS_IPHONE

typedef UITableViewStyle CZTableViewStyle;
enum {
	CZTableViewStylePlain = UITableViewStylePlain,
	CZTableViewStyleGrouped = UITableViewStyleGrouped
};

typedef UITableViewScrollPosition CZTableViewScrollPosition;
enum {
	CZTableViewScrollPositionNone = UITableViewScrollPositionNone,        
	CZTableViewScrollPositionTop = UITableViewScrollPositionTop,    
	CZTableViewScrollPositionMiddle = UITableViewScrollPositionMiddle,   
	CZTableViewScrollPositionBottom = UITableViewScrollPositionBottom
};

typedef UITableViewRowAnimation CZTableViewRowAnimation;
enum {
	CZTableViewRowAnimationFade = UITableViewRowAnimationFade,
	CZTableViewRowAnimationRight = UITableViewRowAnimationRight,
	CZTableViewRowAnimationLeft = UITableViewRowAnimationLeft,
	CZTableViewRowAnimationTop = UITableViewRowAnimationTop,
	CZTableViewRowAnimationBottom = UITableViewRowAnimationBottom,
	CZTableViewRowAnimationNone = UITableViewRowAnimationNone,
};

#else

typedef enum {
    CZTableViewStylePlain,
    CZTableViewStyleGrouped
} CZTableViewStyle;

typedef enum {
    CZTableViewScrollPositionNone,        
    CZTableViewScrollPositionTop,    
    CZTableViewScrollPositionMiddle,   
    CZTableViewScrollPositionBottom
} CZTableViewScrollPosition;

typedef enum {
    CZTableViewRowAnimationFade,
    CZTableViewRowAnimationRight,
    CZTableViewRowAnimationLeft,
    CZTableViewRowAnimationTop,
    CZTableViewRowAnimationBottom,
    CZTableViewRowAnimationNone,
} CZTableViewRowAnimation;

#endif

//_______________________________________________________________________________________________________________
// this protocol represents the data model object. as such, it supplies no information about appearance (including the cells)

@class CZTableView;

#if TARGET_OS_IPHONE
@protocol CZTableViewDataSource <NSObject, UITableViewDataSource>
#else
@protocol CZTableViewDataSource <NSObject>
#endif

#if !TARGET_OS_IPHONE
@required

- (NSInteger)tableView:(CZTableView *)table numberOfRowsInSection:(NSInteger)section;

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (CZTableViewCell *)tableView:(CZTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInTableView:(CZTableView *)tableView;              // Default is 1 if not implemented

- (NSString *)tableView:(CZTableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (CZLabel) if you want something different
- (NSString *)tableView:(CZTableView *)tableView titleForFooterInSection:(NSInteger)section;

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(CZTableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(CZTableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

// Index

- (NSArray *)sectionIndexTitlesForTableView:(CZTableView *)tableView;                                                    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
- (NSInteger)tableView:(CZTableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the CZTableViewCellEditingStyle for the cell), the dataSource must commit the change
- (void)tableView:(CZTableView *)tableView commitEditingStyle:(CZTableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

// Data manipulation - reorder / moving support

- (void)tableView:(CZTableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
#endif

@end

//_______________________________________________________________________________________________________________
// this represents the display and behaviour of the cells.

#if TARGET_OS_IPHONE
@protocol CZTableViewDelegate <NSObject, UITableViewDelegate, CZScrollViewDelegate>
#else
@protocol CZTableViewDelegate <NSObject, CZScrollViewDelegate>
#endif

#if !TARGET_OS_IPHONE
@optional

// Display customization

- (void)tableView:(CZTableView *)tableView willDisplayCell:(CZTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

// Variable height support

- (CGFloat)tableView:(CZTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(CZTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(CZTableView *)tableView heightForFooterInSection:(NSInteger)section;

// Section header & footer information. Views are preferred over title should you decide to provide both

- (CZView *)tableView:(CZTableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
- (CZView *)tableView:(CZTableView *)tableView viewForFooterInSection:(NSInteger)section;   // custom view for footer. will be adjusted to default or specified footer height

// Accessories (disclosures). 

- (CZTableViewCellAccessoryType)tableView:(CZTableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(CZTableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;

// Selection

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (NSIndexPath *)tableView:(CZTableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(CZTableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
// Called after the user changes the selection.
- (void)tableView:(CZTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(CZTableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have CZTableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (CZTableViewCellEditingStyle)tableView:(CZTableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tableView:(CZTableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL)tableView:(CZTableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(CZTableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(CZTableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(CZTableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;               

// Indentation

- (NSInteger)tableView:(CZTableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath; // return 'depth' of row for hierarchies

#endif

@end

CZKIT_EXTERN NSString *const CZTableViewSelectionDidChangeNotification;

//_______________________________________________________________________________________________________________
#if !TARGET_OS_IPHONE
// This category provides convenience methods to make it easier to use an NSIndexPath to represent a section and row
@interface NSIndexPath (CZTableView)

+ (NSIndexPath *)indexPathForRow:(NSUInteger)row inSection:(NSUInteger)section;

@property(nonatomic,readonly) NSUInteger section;
@property(nonatomic,readonly) NSUInteger row;

@end
#endif

CZKIT_EXTERN_CLASS @interface CZTableView : CZ_DYNAMIC_TYPE(CZScrollView, UITableView)
#if !TARGET_OS_IPHONE
{
@private
	CZTableViewStyle            _style;

	id<CZTableViewDataSource>	_dataSource;
	id<CZTableViewDelegate>		_delegate;

	NSMutableArray*             _sectionData;
	CGFloat                     _rowHeight;
	CGFloat                     _sectionHeaderHeight;
	CGFloat                     _sectionFooterHeight;

	BOOL						_isEditing;
	BOOL						_allowsSelection;
	BOOL						_allowsSelectionDuringEditing;

	CZTableViewCellSeparatorStyle _separatorStyle;

	NSMutableArray             *_visibleCells;
	NSMutableDictionary        *_reusableTableCells;
}

@property(nonatomic,readonly) CZTableViewStyle           style;
@property(nonatomic,assign)   id <CZTableViewDataSource> dataSource;
@property(nonatomic,assign)   id <CZTableViewDelegate>   delegate;
@property(nonatomic)          CGFloat                    rowHeight;             // will return the default value if unset
@property(nonatomic)          CGFloat                    sectionHeaderHeight;   // will return the default value if unset
@property(nonatomic)          CGFloat                    sectionFooterHeight;   // will return the default value if unset

/* Data
 * Reloads everything from scratch. redisplays visible rows. because we only keep
 * info about visible rows, this is cheap. will adjust offset if table shrinks
 */
- (void)reloadData;

// Info

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

/*
 - (NSRect)rectForSection:(NSInteger)section;									// includes header, footer and all rows
 - (NSRect)rectForHeaderInSection:(NSInteger)section;
 - (NSRect)rectForFooterInSection:(NSInteger)section;
 - (NSRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath;
 
 - (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point;							// returns nil if point is outside table
 - (NSIndexPath *)indexPathForCell:(CZTableViewCell*)cell;						// returns nil if cell is not visible
 - (NSArray *)indexPathsForRowsInRect:(NSRect)rect;								// returns nil if rect not valid 
 */

- (CZTableViewCell*)cellForRowAtIndexPath:(NSIndexPath*)indexPath;				// returns nil if cell is not visible or index path is out of range
- (NSArray*)visibleCells;
- (NSArray*)indexPathsForVisibleRows;

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(CZTableViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToNearestSelectedRowAtScrollPosition:(CZTableViewScrollPosition)scrollPosition animated:(BOOL)animated;

// Row insertion/deletion/reloading.
/*
 - (void)beginUpdates;   // allow multiple insert/delete of rows and sections to be animated simultaneously. Nestable
 - (void)endUpdates;     // only call insert/delete/reload calls inside an update block.  otherwise things like row count, etc. may be invalid.
 
 - (void)insertSections:(NSIndexSet *)sections withRowAnimation:(CZTableViewRowAnimation)animation;
 - (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(CZTableViewRowAnimation)animation;
 - (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(CZTableViewRowAnimation)animation;
 
 - (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(CZTableViewRowAnimation)animation;
 - (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(CZTableViewRowAnimation)animation;
 - (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(CZTableViewRowAnimation)animation;
 */

// Editing. When set, rows show insert/delete/reorder controls based on data source queries

@property(nonatomic,getter=isEditing) BOOL editing;                             // default is NO. setting is not animated.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@property(nonatomic) BOOL allowsSelection;										// default is YES. Controls whether rows can be selected when not in editing mode
@property(nonatomic) BOOL allowsSelectionDuringEditing;                         // default is NO. Controls whether rows can be selected when in editing mode

// Selection

- (NSIndexPath *)indexPathForSelectedRow;                                       // return nil or index path representing section and row of selection.

// Selects and deselects rows. These methods will not call the delegate methods (-tableView:willSelectRowAtIndexPath: or tableView:didSelectRowAtIndexPath:), nor will it send out a notification.
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(CZTableViewScrollPosition)scrollPosition;
- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

// Appearance

@property(nonatomic) CZTableViewCellSeparatorStyle separatorStyle;              // default is CZTableViewCellSeparatorStyleSingleLine
@property(nonatomic,retain) CZColor* separatorColor;							// default is the standard separator gray

@property(nonatomic,retain) CZView* tableHeaderView;                            // accessory view for above row content. default is nil. not to be confused with section header
@property(nonatomic,retain) CZView* tableFooterView;                            // accessory view below content. default is nil. not to be confused with section footer

- (CZTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;  // Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.
#endif
@end