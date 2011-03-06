//
//  NSFileManager+CZCategories.h
//  CZKit
//
//  Created by Carter Allen on 2/22/10.
//  Copyright 2010 Carter Allen. All rights reserved.
//

#if !TARGET_OS_IPHONE
@interface NSFileManager (CZCategories)
- (NSURL *)cz_applicationSupportDirectory;
- (NSURL *)cz_applicationSupportDirectoryForDomain:(NSSearchPathDomainMask)domain;
- (NSURL *)cz_cachesDirectory;
- (NSURL *)cz_cachesDirectoryForDomain:(NSSearchPathDomainMask)domain;
- (NSURL *)cz_desktopDirectory;
- (NSURL *)cz_desktopDirectoryForDomain:(NSSearchPathDomainMask)domain;
- (NSURL *)cz_documentsDirectory;
- (NSURL *)cz_documentsDirectoryForDomain:(NSSearchPathDomainMask)domain;
- (NSURL *)cz_libraryDirectory;
- (NSURL *)cz_libraryDirectoryForDomain:(NSSearchPathDomainMask)domain;
#ifndef CZ_NAMESPACE_PARANOIA
- (NSURL *)applicationSupportDirectory;
- (NSURL *)applicationSupportDirectoryForDomain:(NSSearchPathDomainMask)domain;
- (NSURL *)cachesDirectory;
- (NSURL *)cachesDirectoryForDomain:(NSSearchPathDomainMask)domain;
- (NSURL *)desktopDirectory;
- (NSURL *)desktopDirectoryForDomain:(NSSearchPathDomainMask)domain;
- (NSURL *)documentsDirectory;
- (NSURL *)documentsDirectoryForDomain:(NSSearchPathDomainMask)domain;
- (NSURL *)libraryDirectory;
- (NSURL *)libraryDirectoryForDomain:(NSSearchPathDomainMask)domain;
#endif
@end
#endif