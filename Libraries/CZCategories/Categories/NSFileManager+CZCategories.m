//
//  NSFileManager+CZCategories.m
//  CZKit
//
//  Created by Carter Allen on 2/22/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

#import "NSFileManager+CZCategories.h"

#if !TARGET_OS_IPHONE
@implementation NSFileManager (CZCategories)
- (NSURL *)cz_applicationSupportDirectory { return [self cz_applicationSupportDirectoryForDomain:NSUserDomainMask]; }
- (NSURL *)cz_applicationSupportDirectoryForDomain:(NSSearchPathDomainMask)domain { return [[self URLsForDirectory:NSApplicationSupportDirectory inDomains:domain] objectAtIndex:0]; }
- (NSURL *)cz_cachesDirectory { return [self cz_cachesDirectoryForDomain:NSUserDomainMask]; }
- (NSURL *)cz_cachesDirectoryForDomain:(NSSearchPathDomainMask)domain { return [[self URLsForDirectory:NSCachesDirectory inDomains:domain] objectAtIndex:0]; }
- (NSURL *)cz_desktopDirectory { return [self cz_desktopDirectoryForDomain:NSUserDomainMask]; }
- (NSURL *)cz_desktopDirectoryForDomain:(NSSearchPathDomainMask)domain { return [[self URLsForDirectory:NSDesktopDirectory inDomains:domain] objectAtIndex:0]; }
- (NSURL *)cz_documentsDirectory { return [self cz_documentsDirectoryForDomain:NSUserDomainMask]; }
- (NSURL *)cz_documentsDirectoryForDomain:(NSSearchPathDomainMask)domain { return [[self URLsForDirectory:NSDocumentDirectory inDomains:domain] objectAtIndex:0]; }
- (NSURL *)cz_libraryDirectory { return [self cz_libraryDirectoryForDomain:NSUserDomainMask]; }
- (NSURL *)cz_libraryDirectoryForDomain:(NSSearchPathDomainMask)domain { return [[self URLsForDirectory:NSLibraryDirectory inDomains:domain] objectAtIndex:0]; }
#ifndef CZ_NAMESPACE_PARANOIA
- (NSURL *)applicationSupportDirectory { return [self cz_applicationSupportDirectory]; }
- (NSURL *)applicationSupportDirectoryForDomain:(NSSearchPathDomainMask)domain { return [self cz_applicationSupportDirectoryForDomain:domain]; }
- (NSURL *)cachesDirectory { return [self cz_cachesDirectory]; }
- (NSURL *)cachesDirectoryForDomain:(NSSearchPathDomainMask)domain { return [self cz_cachesDirectoryForDomain:domain]; }
- (NSURL *)desktopDirectory { return [self cz_desktopDirectory]; }
- (NSURL *)desktopDirectoryForDomain:(NSSearchPathDomainMask)domain { return [self cz_desktopDirectoryForDomain:domain]; }
- (NSURL *)documentsDirectory { return [self cz_documentsDirectory]; }
- (NSURL *)documentsDirectoryForDomain:(NSSearchPathDomainMask)domain { return [self cz_documentsDirectoryForDomain:domain]; }
- (NSURL *)libraryDirectory { return [self cz_libraryDirectory]; }
- (NSURL *)libraryDirectoryForDomain:(NSSearchPathDomainMask)domain { return [self cz_libraryDirectoryForDomain:domain]; }
#endif
@end
#endif