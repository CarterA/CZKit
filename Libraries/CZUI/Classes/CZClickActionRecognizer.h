//
//  CZClickActionRecognizer.h
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZActionRecognizer.h"

/**
 CZClickActionRecognizer is a concrete subclass of CZActionRecognizer which recognizes
 clicks made in a view. It can be configured to require any number of clicks to fire.
 */
@interface CZClickActionRecognizer : CZActionRecognizer {}

/**
 The number of clicks required to cause the action recognizer to transition to
 CZActionRecognizerStateRecognized.
 */
@property (nonatomic, assign) NSUInteger numberOfClicksRequired;

@end