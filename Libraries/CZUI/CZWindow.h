//
//  CZWindow.h
//  CZKit
//
//  Created by Carter Allen on 1/31/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

@class CZView;

@interface CZWindow : NSWindow <NSCoding> {}
@property (nonatomic, retain) CZView *contentView;
@property (nonatomic, assign) NSRect frame;
@end