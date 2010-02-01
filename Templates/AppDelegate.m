//
//  AppDelegate.m
//  CZKit
//
//  Created by Carter Allen on 1/31/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *templatesPath = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/Developer/Shared/XCode/File Templates/CZKit"];
	if ([fileManager fileExistsAtPath:templatesPath]) {
		[install setTitle:@"Reinstall"];
		[uninstall setEnabled:YES];
	}
}
- (IBAction)install:(id)sender {
	NSString *templatesPath = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/Developer/Shared/XCode/File Templates/CZKit"];
	NSArray *templates = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CZTemplates"];
	[[NSFileManager defaultManager] createDirectoryAtPath:templatesPath attributes:nil];
	for (NSString *template in templates) {
		[[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle] pathForResource:template ofType:@"pbfiletemplate"] toPath:[templatesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pbfiletemplate", template]] error:nil];
	}
	[uninstall setEnabled:NO];
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert setAlertStyle:NSWarningAlertStyle];
	[alert addButtonWithTitle:@"Quit"];
	[install setTitle:@"Reinstall"];
	[alert setIcon:[NSImage imageNamed:@"Logo.png"]];
	[alert setMessageText:@"Templates Were Successfully Installed"];
	[alert setInformativeText:@"They will appear when you next open the New File... dialog in XCode."];
	[alert beginSheetModalForWindow:[NSApp keyWindow] modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
}
- (IBAction)uninstall:(id)sender {
	NSString *templatesPath = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/Developer/Shared/XCode/File Templates/CZKit"];
	BOOL error = [[NSFileManager defaultManager] removeItemAtPath:templatesPath error:nil];
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert setAlertStyle:NSWarningAlertStyle];
	[alert addButtonWithTitle:@"Quit"];
	[install setTitle:@"Install"];
	[alert setIcon:[NSImage imageNamed:@"Logo.png"]];
	if (!error) {
		[alert setMessageText:@"Templates Could Not Be Uninstalled"];
		[alert setInformativeText:@"Try manually removing ~/Library/Application Support/Developer/Shared/XCode/File Templates/CZKit"];
	}
	else [alert setMessageText:@"Templates Successfully Uninstalled"];		
	[alert beginSheetModalForWindow:[NSApp keyWindow] modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
}
- (void)sheetDidEnd:(NSAlert *)alert returnCode:(int)returnCode contextInfo:(void *)contextInfo { [NSApp terminate:self]; }
@end