//
//  CZTableView.m
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZTableView.h"
#import "CZColor.h"

#if !TARGET_OS_IPHONE
static inline CGRect CGRectFromOffsetHeight(float offset, float height) {
	return CGRectMake(0.0f, offset, 100.0f, height);
}

@interface CZTableView (Private)
- (void)queueReusableCell:(CZTableViewCell*)aTableViewCell;
- (void)layoutVisibleCells;
- (void)removeInvisibleCells;
- (void)clearAllCells;
@end
#endif


@implementation CZTableView
#if !TARGET_OS_IPHONE
@synthesize style=_style, dataSource=_dataSource, delegate=_delegate;
@synthesize rowHeight=_rowHeight, sectionHeaderHeight=_sectionHeaderHeight, sectionFooterHeight=_sectionFooterHeight;
@synthesize editing=_isEditing, allowsSelection=_allowsSelection, allowsSelectionDuringEditing=_allowsSelectionDuringEditing;
@synthesize separatorStyle=_separatorStyle, separatorColor=_separatorColor;
@synthesize tableHeaderView=_tableHeaderView, tableFooterView=_tableFooterView;

- (void)setupTableViewDefaults {
	_rowHeight = 44.0f;
	_sectionHeaderHeight = 22.0f;
	_sectionFooterHeight = 22.0f;
	_allowsSelection = YES;
	_allowsSelectionDuringEditing = NO;
	_separatorStyle = CZTableViewCellSeparatorStyleSingleLine;
	_separatorColor = [[CZColor grayColor] retain];
	_reusableTableCells = [[NSMutableDictionary alloc] init];
	_visibleCells = [[NSMutableArray alloc] init];
	_sectionData = [[NSMutableArray alloc] init];
	
	//	self.hasVerticalScroller = YES;
	//	self.hasHorizontalScroller = NO;
	//	self.autohidesScrollers = NO;
	
	//	((CZView*)self.contentView).autoresizingMask = CZViewAutoresizingFlexibleWidth | CZViewAutoresizingFlexibleBottomMargin;
}

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {
		[self setupTableViewDefaults];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if((self = [super initWithCoder:aDecoder])) {
		[self setupTableViewDefaults];
	}
	
	return self;
}

#pragma mark Todo

- (void)reloadData {
	float height = 0.0f;
	NSInteger sections = 1;
	BOOL variableRowHeights = [self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)];
	
	if([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
		sections = [self.dataSource numberOfSectionsInTableView:self];
	}
	
	[_sectionData removeAllObjects];
	
	for(int section = 0; section < sections; section++) {
		NSInteger rows = [self.dataSource tableView:self numberOfRowsInSection:section];
		NSMutableArray* rowInfo = [[NSMutableArray alloc] initWithCapacity:rows];
		float offsetY = height;
		
		for(int row = 0; row < rows; row++) {
			float rowHeight = self.rowHeight;
			
			if(variableRowHeights) {
				rowHeight = [self.delegate tableView:self heightForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
			}
			
			NSRect rowRect = NSMakeRect(0.0f, height, self.contentView.frame.size.width, rowHeight);
			[rowInfo addObject:[NSValue valueWithRect:rowRect]];
			
			height += rowHeight;
		}
		
		NSMutableDictionary* sectionInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
		[sectionInfo setObject:rowInfo forKey:@"rows"];
		[rowInfo release];
		
		NSRect sectionRect = NSMakeRect(0.0f, offsetY, self.contentView.frame.size.width, height-offsetY);
		[sectionInfo setObject:[NSValue valueWithRect:sectionRect] forKey:@"rect"];
		[_sectionData addObject:sectionInfo];
		[sectionInfo release];
	}
	
	
	if(height == 0) height = 1.0f;
	self.contentSize = CGSizeMake([self contentSize].width, height);
	
	[self clearAllCells];
	[self layoutVisibleCells];
}

- (NSInteger)numberOfSections {
	if([_dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
		return [_dataSource numberOfSectionsInTableView:self];
	} else {
		return 1;
	}
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
	return [_dataSource tableView:self numberOfRowsInSection:section];
}

- (CZTableViewCell*)cellForRowAtIndexPath:(NSIndexPath*)indexPath {
	return [_dataSource tableView:self cellForRowAtIndexPath:indexPath];
}

- (NSArray*)visibleCells {
	return _visibleCells;
}

- (NSArray*)indexPathsForVisibleRows {
	// ToDo: indexPathsForVisibleRows
	return nil;
}

- (void)layoutVisibleCells {
	CGRect clipViewBounds = self.contentView.bounds;
	NSArray* subviews = [[[self.contentView subviews] copy] autorelease];
	
	NSInteger section = 0;
	for(NSDictionary* sectionInfo in _sectionData) {
		CGRect sectionRect = NSRectToCGRect([[sectionInfo objectForKey:@"rect"] rectValue]);
		sectionRect.origin.x = 0.0f;
		sectionRect.size.width = self.contentView.frame.size.width;
		
		if(!CGRectIntersectsRect(clipViewBounds, sectionRect)) {
			section++;
			continue;
		}
		
		NSInteger row = 0;
		for(NSValue* rowRectValue in [sectionInfo objectForKey:@"rows"]) {
			NSRect rowRect = [rowRectValue rectValue];
			rowRect.origin.x = 0.0f;
			rowRect.size.width = self.contentView.frame.size.width;
			
			if(!CGRectIntersectsRect(clipViewBounds, NSRectToCGRect(rowRect))) {
				row++;
				continue;
			}
			
			BOOL skip = NO;
			for(CZView* view in subviews) {
				if(![view isKindOfClass:[CZTableViewCell class]]) continue;
				if(CGRectIntersectsRect(NSRectToCGRect(rowRect), view.frame)) {
					skip = YES;
					break;
				}
			}
			
			if(skip) {
				row++;
				continue;
			}
			
			NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:section];
			
			CZTableViewCell* aCell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
			// if(!aCell.separatorColor) aCell.separatorColor = _separatorColor;
			
			aCell.frame = rowRect;
			[aCell setNeedsLayout];
			[aCell setNeedsDisplay];
			[self.contentView addSubview:aCell];
			[aCell layoutIfNeeded];
			[_visibleCells addObject:aCell];
			
			row++;
		}
		
		section++;
	}
}

- (void)clearAllCells {
	[_visibleCells removeAllObjects];
	
	NSMutableSet* cells = [[NSMutableSet alloc] init];
	for(CZTableViewCell* cell in [self.contentView subviews]) {
		if(![cell isKindOfClass:[CZTableViewCell class]]) continue;
		[cells addObject:cell];
	}
	
	for(CZTableViewCell* cell in cells) {
		[self queueReusableCell:cell];
		[cell removeFromSuperview];
	}
	
	[cells release];
}

- (void)removeInvisibleCells {
	NSMutableSet* cellsToRemove = [NSMutableSet set];
	CGRect clipViewBounds = self.contentView.bounds;
	
	for(CZTableViewCell* cell in [self.contentView subviews]) {
		if(![cell isKindOfClass:[CZTableViewCell class]]) continue;
		if(CGRectIntersectsRect(clipViewBounds, cell.frame)) continue;
		[cellsToRemove addObject:cell];
	}
	
	[cellsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
	[_visibleCells removeObjectsInArray:[cellsToRemove allObjects]];
	
	for(CZTableViewCell* cell in cellsToRemove) {
		[self queueReusableCell:cell];
	}
}

#pragma mark -
#pragma mark Live resizing methods
//- (void)viewWillStartLiveResize {
//	[super viewWillStartLiveResize];
//	liveResizeScrollOffset = self.contentOffset;
//}
//
//- (void)viewDidEndLiveResize {
//	[super viewDidEndLiveResize];
//	[self removeInvisibleCells];
//	[self layoutVisibleCells];
//}

#pragma mark -

- (void)setContentOffset:(CGPoint)inContentOffset {
	[super setContentOffset:inContentOffset];
	[self setNeedsLayout];
}

- (void)setFrame:(CGRect)frameRect {
	[super setFrame:frameRect];
	[self setNeedsLayout];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self removeInvisibleCells];
	[self layoutVisibleCells];
}

#pragma mark Todo
- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(CZTableViewScrollPosition)scrollPosition animated:(BOOL)animated {
	
}

#pragma mark Todo
- (void)scrollToNearestSelectedRowAtScrollPosition:(CZTableViewScrollPosition)scrollPosition animated:(BOOL)animated {
	
}

#pragma mark Todo
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
}

#pragma mark Todo
- (NSIndexPath *)indexPathForSelectedRow {
	return nil;
}

#pragma mark Todo
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(CZTableViewScrollPosition)scrollPosition {
	
}

#pragma mark Todo
- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	
}

- (CZTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
	if(!identifier) return nil;
	
	CZTableViewCell* aTableViewCell = [[_reusableTableCells objectForKey:identifier] anyObject];
	if(!aTableViewCell) return nil;
	
	[aTableViewCell retain];
	
	[[_reusableTableCells objectForKey:identifier] removeObject:aTableViewCell];
	
	return [aTableViewCell autorelease];
}

- (void)queueReusableCell:(CZTableViewCell*)aTableViewCell {
	if(!aTableViewCell) return;
	if(!aTableViewCell.reuseIdentifier) return;
	
	if([[_reusableTableCells objectForKey:aTableViewCell.reuseIdentifier] containsObject:aTableViewCell]) return;
	
	[aTableViewCell prepareForReuse];
	
	if(![_reusableTableCells objectForKey:aTableViewCell.reuseIdentifier]) {
		[_reusableTableCells setObject:[NSMutableSet setWithCapacity:1] forKey:aTableViewCell.reuseIdentifier];
	}
	
	[[_reusableTableCells objectForKey:aTableViewCell.reuseIdentifier] addObject:aTableViewCell];
}

- (void)dealloc {
	[_sectionData release];
	[_visibleCells release];
	[_reusableTableCells release];
	[super dealloc];
}

@end

@implementation NSIndexPath (CZTableView)

+ (NSIndexPath *)indexPathForRow:(NSUInteger)row inSection:(NSUInteger)section {
	NSUInteger indexArr[] = {section,row};
	return [NSIndexPath indexPathWithIndexes:indexArr length:2];
}

- (NSUInteger)section {
	return [self indexAtPosition:0];
}

- (NSUInteger)row {
	return [self indexAtPosition:1];
}

#endif // !TARGET_OS_IPHONE

@end