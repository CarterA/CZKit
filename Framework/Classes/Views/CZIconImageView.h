/*
 
 CZIconImageView.h
 Subclass of NSImageView, providing easy support for the display of file icons
 with full drag + drop support.
 
 This class is a member of the CZKit framework.
 
 Created by Carter Allen on 8/19/09.
 Copyright 2009 Carter Allen. All rights reserved.
 
 For usage information, please see the included documentation.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import <Cocoa/Cocoa.h>

typedef enum {
    CZIconImageViewRevealInFinderBehavior,
    CZIconImageViewOpenInDefaultEditorBehavior,
    CZIconImageViewOpenInOtherEditorBehavior
} CZIconImageViewDoubleClickBehavior;

@interface CZIconImageView : NSImageView <NSCoding> {
	IBOutlet id delegate;	
	int iconSize;
	int doubleClickBehavior;
	BOOL isDragSource;
	BOOL canDoubleClickIcon;
	NSArray *allowedFileExtensions;
	NSString *otherEditor;
	NSString *representedFile;
}
- (NSString *)representedFile;
- (void)setRepresentedFile:(NSString *)filePath;
- (CZIconImageViewDoubleClickBehavior)doubleClickBehavior;
- (void)setDoubleClickBehavior:(CZIconImageViewDoubleClickBehavior)newBehavior;
@property int iconSize;
@property BOOL isDragSource, canDoubleClickIcon;
@property(assign) id delegate;
@property(nonatomic, copy) NSArray *allowedFileExtensions;
@property(nonatomic, copy) NSString *otherEditor;
@property (nonatomic, copy) NSString *representedFile;
@end
@interface CZIconImageViewDelegate
- (void)CZIconImageView:(CZIconImageView *)iconImageView representedFileDidChangeToFile:(NSString *)file;
@end