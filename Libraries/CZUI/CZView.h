//
//  CZView.h
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

@class CZActionRecognizer;

@interface CZView : NSView <NSCoding> {}
@property (nonatomic, retain, readonly) NSArray *actionRecognizers;
@property (nonatomic, assign) NSRect frame;
+ (id)viewWithFrame:(NSRect)frame;
- (void)addActionRecognizer:(CZActionRecognizer *)actionRecognizer;
- (void)removeActionRecognizer:(CZActionRecognizer *)actionRecognizer;
@end