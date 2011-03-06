//
//  CZActionRecognizerSubclass.h
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

@interface CZActionRecognizer ()
@property (nonatomic, readwrite) CZActionRecognizerState state;
- (void)receivedEvent:(NSEvent *)event;
- (void)reset;
@end
