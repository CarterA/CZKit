//
//  AppDelegate.h
//  CZKit
//
//  Created by Carter Allen on 1/31/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject {
	IBOutlet NSButton *install;
	IBOutlet NSButton *uninstall;
}
- (IBAction)install:(id)sender;
- (IBAction)uninstall:(id)sender;
@end