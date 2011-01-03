//
//  CZActionRecognizer.h
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

@class CZView, CZActionRecognizer;

typedef void (^CZActionHandler)(CZActionRecognizer *recognizer);

typedef enum {
	CZActionRecognizerStatePossible,
    CZActionRecognizerStateBegan,
    CZActionRecognizerStateChanged,
    CZActionRecognizerStateEnded,
    CZActionRecognizerStateCancelled,
    CZActionRecognizerStateFailed,
    CZActionRecognizerStateRecognized = CZActionRecognizerStateEnded
} CZActionRecognizerState;

@interface CZActionRecognizer : NSObject {}
@property (nonatomic, retain, readonly) NSArray *targetActionPairs;
@property (nonatomic, retain, readonly) NSArray *handlers;
@property (nonatomic, readonly) CZActionRecognizerState state;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic, readonly) CZView *view;
+ (id)actionRecognizer;
+ (id)actionRecognizerWithHandler:(CZActionHandler)handler;
- (id)initWithHandler:(CZActionHandler)handler;
- (void)addHandler:(CZActionHandler)handler;
- (void)addTarget:(id)target action:(SEL)action;
- (void)removeTarget:(id)target action:(SEL)action;
@end