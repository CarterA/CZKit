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
	CZActionRecognizerStateNull,
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

/**
 This dictionary contains all the handlers that have been added to the action recognizer.
 The CZActionRecognizerState constants are used as the keys for the dictionary, and each
 object in the dictionary is an NSArray of CZActionHandler blocks. Some or all of the keys
 or arrays may be nil. You cannot manipulate this property directly. Instead, use the
 addHandler:forState: method.
 
 @see addHandler:forState:
 */
@property (nonatomic, retain, readonly) NSDictionary *handlers;

/**
 The current state of the action recognizer. Subclasses must use the readwrite version of
 this property which is declared in the CZActionRecognizerSubclass.h header file.
 */
@property (nonatomic, readonly) CZActionRecognizerState state;

/**
 This property indicates whether the action recognizer is enabled. It can be set at any
 time, and if it is set to `NO` while the action recognizer is in the middle of
 recognizing, then it will change to the CZActionRecognizerCancelled state and trigger
 any associated handlers.
 */
@property (nonatomic, getter=isEnabled) BOOL enabled;

/**
 The view that the action recognizer receives and handles events for. You cannot set this
 property directly. Instead, use the addActionRecognizer: method on a CZView.
 */
@property (nonatomic, readonly) CZView *view;

/**
 Allocates and initializes an action recognizer without any handlers.
 @return A fully initialized action recognizer with no handlers configured for any of the
 possible states.
 */
+ (id)actionRecognizer;

/**
 Allocates and initializes an action recognizer with a single handler set for the
 CZActionRecognizerStateRecognized state.
 @param handler The handler to be run when the action recognizer transitions to the
 CZActionRecognizerStateRecognized state.
 @return A fully initialized action recognizer with one handler configured to execute
 after the action recognizer has been recognized.
 */
+ (id)actionRecognizerWithHandler:(CZActionHandler)handler;

/**
 Allocates and initializes an action recognizer with a single handler set for the
 specified state.
 @param handler The handler to be run when the action recognizer transitions to the
 specified state.
 @param state The state which the handler will be executed for.
 @return A fully initialized action recognizer with one handler configured to execute
 after the action recognizer has transitioned to the specified state.
 */
+ (id)actionRecognizerWithHandler:(CZActionHandler)handler forState:(CZActionRecognizerState)state;

/**
 Initializes an action recognizer with a single handler set for the specified state.
 @param handler The handler to be run when the action recognizer transitions to the
 specified state.
 @param state The state which the handler will be executed for.
 @return An initialized action recognizer with one handler configured to execute
 after the action recognizer has transitioned to the specified state.
 */
- (id)initWithHandler:(CZActionHandler)handler forState:(CZActionRecognizerState)state;

/**
 Configures the action recognizer to execute the specified handler when the recognizer
 transitions to the specified state.
 @param handler The handler to be run when the action recognizer transitions to the
 specified state.
 @param state The state which the handler will be executed for.
 */
- (void)addHandler:(CZActionHandler)handler forState:(CZActionRecognizerState)state;

@end