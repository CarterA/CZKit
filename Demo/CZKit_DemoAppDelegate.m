//
//  CZKit_DemoAppDelegate.m
//  CZKit Demo
//
//  Created by Carter Allen on 2/4/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CZKit_DemoAppDelegate.h"

@implementation CZKit_DemoAppDelegate
@synthesize window=_window, tableView=_tableView;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	self.window = [[CZWindow alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	self.window.layer.backgroundColor = [[CZColor redColor] CGColor];
	
	self.tableView = [[CZTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.tableView reloadData];
	[self.window addSubview:self.tableView];
	self.tableView.layer.borderColor = [[CZColor redColor] CGColor];
	self.tableView.layer.borderWidth = 1;
	
	[self.window makeKeyAndVisible];
	
	return YES;
	
}
- (NSInteger)numberOfSectionsInTableView:(CZTableView *)tableView {
	return 1;
}
- (NSInteger)tableView:(CZTableView *)table numberOfRowsInSection:(NSInteger)section {
	return 100;
}
- (CZTableViewCell *)tableView:(CZTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *identifier = @"CZKitDemoIdentifier";
	CZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[CZTableViewCell alloc] initWithStyle:CZTableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = @"Table Item";
    return cell;
}
@end