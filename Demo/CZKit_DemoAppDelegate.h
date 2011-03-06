//
//  CZKit_DemoAppDelegate.h
//  CZKit Demo
//
//  Created by Carter Allen on 2/4/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

@interface CZKit_DemoAppDelegate : NSObject <CZ_DYNAMIC_TYPE(NSApplicationDelegate, UIApplicationDelegate), CZTableViewDelegate, CZTableViewDataSource> {}
@property (nonatomic, retain) CZWindow *window;
@property (nonatomic, retain) CZTableView *tableView;
@end