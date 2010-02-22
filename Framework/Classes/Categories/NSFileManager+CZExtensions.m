//
//  NSFileManager+CZExtensions.m
//  CZKit
//
//  Created by Carter Allen on 2/22/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "NSFileManager+CZExtensions.h"

@implementation NSFileManager (CZExtensions)
- (NSURL *)applicationSupportDirectory { return [self applicationSupportDirectoryForDomain:NSUserDomainMask]; }
- (NSURL *)applicationSupportDirectoryForDomain:(NSSearchPathDomainMask)domain { return [[self URLsForDirectory:NSApplicationSupportDirectory inDomains:domain] objectAtIndex:0]; }
- (NSURL *)cachesDirectory { return [self cachesDirectoryForDomain:NSUserDomainMask]; }
- (NSURL *)cachesDirectoryForDomain:(NSSearchPathDomainMask)domain { return [[self URLsForDirectory:NSCachesDirectory inDomains:domain] objectAtIndex:0]; }
- (NSURL *)desktopDirectory { return [self desktopDirectoryForDomain:NSUserDomainMask]; }
- (NSURL *)desktopDirectoryForDomain:(NSSearchPathDomainMask)domain { return [[self URLsForDirectory:NSDesktopDirectory inDomains:domain] objectAtIndex:0]; }
- (NSURL *)documentsDirectory { return [self documentsDirectoryForDomain:NSUserDomainMask]; }
- (NSURL *)documentsDirectoryForDomain:(NSSearchPathDomainMask)domain { return [[self URLsForDirectory:NSDocumentsDirectory inDomains:domain] objectAtIndex:0]; }
- (NSURL *)libraryDirectory { return [self libraryDirectoryForDomain:NSUserDomainMask]; }
- (NSURL *)libraryDirectoryForDomain:(NSSearchPathDomainMask)domain { return [[self URLsForDirectory:NSLibraryDirectory inDomains:domain] objectAtIndex:0]; }
@end
