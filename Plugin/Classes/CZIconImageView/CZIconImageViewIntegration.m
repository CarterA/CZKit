//
//  CZIconImageViewIntegration.m
//  CZKit
//
//  Created by Carter Allen on 12/26/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CZIconImageViewInspector.h"

@implementation CZIconImageView (CZIconImageViewIntegration)
- (void)ibPopulateKeyPaths:(NSMutableDictionary *)keyPaths {
    [super ibPopulateKeyPaths:keyPaths];
    [[keyPaths objectForKey:IBAttributeKeyPaths] addObjectsFromArray:[NSArray arrayWithObjects:@"isDragSource", @"representedFile", @"iconSize", @"canDoubleClickIcon", nil]];
}
- (void)ibPopulateAttributeInspectorClasses:(NSMutableArray *)classes {
    [super ibPopulateAttributeInspectorClasses:classes];
    [classes addObject:[CZIconImageViewInspector class]];
}
@end