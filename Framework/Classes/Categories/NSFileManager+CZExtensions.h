//
//  NSFileManager+CZExtensions.h
//  CZKit
//
//  Created by Carter Allen on 2/22/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

@interface NSFileManager (CZExtensions)
- (NSURL *)applicationSupportDirectory;
- (NSURL *)applicationSupportDirectoryForDomain:(NSSearchPathDomainMask)domain;
- (NSURL *)cachesDirectory;
- (NSURL *)cachesDirectoryForDomain:(NSSearchPathDomainMask)domain;
- (NSURL *)libraryDirectory;
- (NSURL *)libraryDirectoryForDomain:(NSSearchPathDomainMask)domain;
@end