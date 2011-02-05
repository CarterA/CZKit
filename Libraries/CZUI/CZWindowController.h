//
//  CZWindowController.h
//  CZKit
//
//  Created by Carter Allen on 1/31/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

@class CZWindow;

@interface CZWindowController : NSWindowController {}
@property (nonatomic, retain) CZWindow *window;
- (id)initWithWindow:(CZWindow *)theWindow;
@end