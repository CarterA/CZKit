//
//  CZIconImageView.m
//
//  Created by Carter Allen on 8/18/09.
//  Copyright 2009 Carter Allen. All rights reserved.
//
//  See header file for license information.

#if !TARGET_OS_IPHONE

#import "CZIconImageView.h"
@implementation CZIconImageView
#pragma mark -
#pragma mark Properties
@synthesize iconSize;
@synthesize isDragSource;
@synthesize canDoubleClickIcon;
@synthesize allowedFileExtensions;
@synthesize otherEditor;
@synthesize delegate;
#pragma mark -
#pragma mark Archiving Support
- (void)encodeWithCoder:(NSCoder *)coder {
	[super encodeWithCoder:coder];
	if ([coder allowsKeyedCoding]) {
		[coder encodeInt:iconSize forKey:@"iconSize"];
		[coder encodeBool:isDragSource forKey:@"isDragSource"];
		[coder encodeBool:canDoubleClickIcon forKey:@"canDoubleClickIcon"];
		[coder encodeObject:allowedFileExtensions forKey:@"allowedFileExtensions"];
		[coder encodeObject:otherEditor forKey:@"otherEditor"];
		[coder encodeObject:representedFile forKey:@"representedFile"];
		[coder encodeInt:doubleClickBehavior forKey:@"doubleClickBehavior"];
	}
}
- (id)initWithCoder:(NSCoder *)coder {
	if ((self = [super initWithCoder:coder]) != nil) {
		if ([coder allowsKeyedCoding]) {
			if ([coder containsValueForKey:@"iconSize"])
				[self setIconSize:[coder decodeIntForKey:@"iconSize"]];
			if ([coder containsValueForKey:@"isDragSource"])
				[self setIsDragSource:[coder decodeBoolForKey:@"isDragSource"]];
			if ([coder containsValueForKey:@"canDoubleClickIcon"])
				[self setCanDoubleClickIcon:[coder decodeBoolForKey:@"canDoubleClickIcon"]];
			if ([coder containsValueForKey:@"allowedFileExtensions"])
				[self setAllowedFileExtensions:[coder decodeObjectForKey:@"allowedFileExtensions"]];
			if ([coder containsValueForKey:@"otherEditor"])
				[self setOtherEditor:[coder decodeObjectForKey:@"otherEditor"]];
			if ([coder containsValueForKey:@"representedFile"])
				[self setRepresentedFile:[coder decodeObjectForKey:@"representedFile"]];
			if ([coder containsValueForKey:@"doubleClickBehavior"])
				[self setDoubleClickBehavior:[coder decodeIntForKey:@"doubleClickBehavior"]];
		}
	}
	return self;
}
#pragma mark -
#pragma mark General
+ (void)initialize {
	if (self == [CZIconImageView class]) {
		[self exposeBinding:@"iconSize"];
		[self exposeBinding:@"isDragSource"];
		[self exposeBinding:@"canDoubleClickIcon"];
		[self exposeBinding:@"allowedFileExtensions"];
		[self exposeBinding:@"otherEditor"];
		[self exposeBinding:@"representedFile"];
	}
}
- (void)awakeFromNib {
	//Set default values
	[self setIsDragSource:YES];
	[self setCanDoubleClickIcon:YES];
	if ([self isEditable])
		[self registerForDraggedTypes:[NSArray arrayWithObjects: NSFilenamesPboardType, nil]];
	[self setTarget:self];
	[self setAction:@selector(mouseDown:)];
}
- (void)dealloc {
	[self unbind:@"iconSize"];
	[self unbind:@"isDragSource"];
	[self unbind:@"canDoubleClickIcon"];
	[self unbind:@"allowedFileExtensions"];
	[self unbind:@"otherEditor"];
	[self unbind:@"representedFile"];
	[super dealloc];
}
#pragma mark -
#pragma mark Custom Getters/Setters
- (NSString *)representedFile {
	return representedFile;
}
- (void)setRepresentedFile:(NSString *)filePath {
	representedFile = [[filePath stringByStandardizingPath] copy];
	if ([delegate respondsToSelector:@selector(CZIconImageView:representedFileDidChangeToFile:)])
		[[self delegate] CZIconImageView:self representedFileDidChangeToFile:representedFile];
	if ([representedFile isEqualToString:@""] || representedFile == nil)
		representedFile = @"/System/";
	NSImage *fullImage = [[NSWorkspace sharedWorkspace] iconForFile:representedFile];
	NSSize imageSize;
	if ((iconSize == 0) && ([self frame].size.width != 0)) {
		imageSize.width = [self frame].size.width;
		imageSize.height = [self frame].size.width;
	}
	else if ([self frame].size.width == 0) {
		imageSize.width = 10;
		imageSize.height = 10;
	}
	else {
		imageSize.width = iconSize;
		imageSize.height = iconSize;
	}
	//[fullImage setSize:imageSize];
	[self setImage:fullImage];
}
- (CZIconImageViewDoubleClickBehavior)doubleClickBehavior {
	return doubleClickBehavior;
}
- (void)setDoubleClickBehavior:(CZIconImageViewDoubleClickBehavior)newBehavior {
	doubleClickBehavior = newBehavior;
}
#pragma mark -
#pragma mark Drag Destination Methods
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
	[[sender draggingPasteboard] types];
	NSArray *fileNames = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
	if ([fileNames count] != 1)
		return NSDragOperationNone;
	if ([self allowedFileExtensions]) {
		NSString *extension = [[[fileNames objectAtIndex:0] pathExtension] lowercaseString];
		if (![[self allowedFileExtensions] containsObject:extension]) return NSDragOperationNone;
	}
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) == NSDragOperationGeneric)
        return NSDragOperationGeneric;
    else
        return NSDragOperationNone;
}
- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) == NSDragOperationGeneric) return NSDragOperationGeneric;
    else return NSDragOperationNone;
}
- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender {
	[[sender draggingPasteboard] types];
	NSArray *fileNames = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
	if ([fileNames count] != 1) return NO;
	if ([self allowedFileExtensions]) if (![[self allowedFileExtensions] containsObject:[[[fileNames objectAtIndex:0] pathExtension] lowercaseString]]) return NO;
    return YES;
}
- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard *paste = [sender draggingPasteboard];
    NSArray *types = [NSArray arrayWithObjects:NSFilenamesPboardType, nil];
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSData *carriedData = [paste dataForType:desiredType];
    if (nil == carriedData) return NO;
    else {
        if ([desiredType isEqualToString:NSFilenamesPboardType]) {
            NSArray *fileArray = [paste propertyListForType:@"NSFilenamesPboardType"];
			if ([fileArray count] != 1) {
				return NO;
			}
            NSString *path = [fileArray objectAtIndex:0];
			[self setRepresentedFile:path];
        }
        else return NO;
    }
    return YES;
}
- (void)concludeDragOperation:(id <NSDraggingInfo>)sender { [self setNeedsDisplay:YES]; }
#pragma mark -
#pragma mark Drag Source Methods
- (void)mouseDown:(NSEvent *)theEvent {
	if ([self image]) {
		if ([self canDoubleClickIcon]) {
			if ([theEvent clickCount] >= 2) {
				switch (doubleClickBehavior) {
					case CZIconImageViewRevealInFinderBehavior:
						[[NSWorkspace sharedWorkspace] selectFile:[[NSURL fileURLWithPath:representedFile] path] inFileViewerRootedAtPath:nil];
						break;
					case CZIconImageViewOpenInDefaultEditorBehavior:
						[[NSWorkspace sharedWorkspace] openURL:[NSURL fileURLWithPath:representedFile]];
						break;
					case CZIconImageViewOpenInOtherEditorBehavior:
						[[NSWorkspace sharedWorkspace] openFile:representedFile withApplication:otherEditor];
						break;
					default:
						[[NSWorkspace sharedWorkspace] selectFile:[[NSURL fileURLWithPath:representedFile] path] inFileViewerRootedAtPath:nil];
						break;
				}
				
			}
		}
	}
}
- (void)startDrag:(NSEvent *)event {
    NSPasteboard *pb = [NSPasteboard pasteboardWithName: NSDragPboard];
    NSImage *dragImage;
    NSPoint dragPoint;
    dragPoint = NSMakePoint(([self bounds].size.width - [[self image] size].width) / 2, ([self bounds].size.height - [[self image] size].height) / 2);
    [pb declareTypes: [NSArray arrayWithObject: NSFilenamesPboardType] owner: self];
	[pb setPropertyList:[NSArray arrayWithObject:representedFile] forType:NSFilenamesPboardType];
    dragImage = [[[NSImage alloc] initWithSize: [[self image] size]] autorelease];
	if (!([dragImage size].height == 0.0 && [dragImage size].width == 0.0)) {
		[dragImage lockFocus];
		[[self image] dissolveToPoint: NSMakePoint(0.0f,0.0f) fraction: .5f];
		[dragImage unlockFocus];
	}
    [self dragImage:dragImage at:dragPoint offset:NSMakeSize(0,0) event:event pasteboard:pb source:self slideBack:YES];
}
- (void)mouseDragged:(NSEvent *)event {
	if ([self image]) {
		if ([self isDragSource]) {
			[self startDrag:event];
		}
	}
}
- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
	return YES;
}
#pragma mark -
#pragma mark Bindings
- (Class)valueClassForBinding:(NSString*)binding {
	if ([binding isEqualToString:@"otherEditor"] || [binding isEqualToString:@"representedFile"]) return [NSString class];
	else if ([binding isEqualToString:@"allowedFileExtensions"]) return [NSArray class];
	else if ([binding isEqualToString:@"iconSize"] || [binding isEqualToString:@"isDragSource"] || [binding isEqualToString:@"canDoubleClickIcon"]) return nil;
	else return [super valueClassForBinding:binding];
}
@end
#endif