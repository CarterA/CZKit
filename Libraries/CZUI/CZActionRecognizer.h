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

/**
 CZActionRecognizer is an abstract base class for concrete action recognizer classes.
 An action recognizer abstracts the process of handling raw events, replacing it with
 a simple system based on states and handlers. The following classes are concrete
 subclasses of CZActionRecognizer:
 
 CZClickActionRecognizer
 
 An action recognizer works by being attached to a CZView via the addActionRecognizer:
 method. Events that are sent to the view are passed to each action recognizer, which
 process the events internally. If any of the events constitute a change in state, then
 the state property will be updated and any handlers that are registered for the new
 state will be executed.
*/
@interface CZActionRecognizer : NSObject {}
@property (nonatomic, retain, readonly) NSArray *handlers;
@property (nonatomic, readonly) CZActionRecognizerState state;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic, readonly) CZView *view;
+ (id)actionRecognizer;
+ (id)actionRecognizerWithHandler:(CZActionHandler)handler;
- (id)initWithHandler:(CZActionHandler)handler;
- (void)addHandler:(CZActionHandler)handler;
@end