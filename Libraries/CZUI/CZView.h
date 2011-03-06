//
//  CZView.h
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZMacros.h"

#if !TARGET_OS_IPHONE

@class CZActionRecognizer;
@class CZColor;
@class CALayer;
@class NSEvent;
@class CZViewController;

typedef enum {
    CZViewAnimationCurveEaseInOut,         // slow at beginning and end
    CZViewAnimationCurveEaseIn,            // slow at beginning
    CZViewAnimationCurveEaseOut,           // slow at end
    CZViewAnimationCurveLinear
} CZViewAnimationCurve;

typedef enum {
    CZViewContentModeScaleToFill,
    CZViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
    CZViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
    CZViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
    CZViewContentModeCenter,              // contents remain same size. positioned adjusted.
    CZViewContentModeTop,
    CZViewContentModeBottom,
    CZViewContentModeLeft,
    CZViewContentModeRight,
    CZViewContentModeTopLeft,
    CZViewContentModeTopRight,
    CZViewContentModeBottomLeft,
    CZViewContentModeBottomRight,
} CZViewContentMode;

typedef enum {
    CZViewAnimationTransitionNone,
    CZViewAnimationTransitionFlipFromLeft,
    CZViewAnimationTransitionFlipFromRight,
    CZViewAnimationTransitionCurlUp,
    CZViewAnimationTransitionCurlDown,
} CZViewAnimationTransition;

enum {
    CZViewAutoresizingNone                 = 0,
    CZViewAutoresizingFlexibleLeftMargin   = 1 << 0,
    CZViewAutoresizingFlexibleWidth        = 1 << 1,
    CZViewAutoresizingFlexibleRightMargin  = 1 << 2,
    CZViewAutoresizingFlexibleTopMargin    = 1 << 3,
    CZViewAutoresizingFlexibleHeight       = 1 << 4,
    CZViewAutoresizingFlexibleBottomMargin = 1 << 5
};
typedef unsigned int CZViewAutoresizing;

enum {
    CZViewAnimationOptionLayoutSubviews            = 1 <<  0,
    CZViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
    CZViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
    CZViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
    CZViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
    CZViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
    CZViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested duration
    CZViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
    CZViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
    
    CZViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
    CZViewAnimationOptionCurveEaseIn               = 1 << 16,
    CZViewAnimationOptionCurveEaseOut              = 2 << 16,
    CZViewAnimationOptionCurveLinear               = 3 << 16,
    
    CZViewAnimationOptionTransitionNone            = 0 << 20, // default
    CZViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
    CZViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
    CZViewAnimationOptionTransitionCurlUp          = 3 << 20,
    CZViewAnimationOptionTransitionCurlDown        = 4 << 20,
};
typedef NSUInteger CZViewAnimationOptions;

#endif

@interface CZView : CZ_DYNAMIC_TYPE(NSResponder, UIResponder) {}
#if !TARGET_OS_IPHONE
@property (nonatomic, assign) BOOL userInteractionEnabled;

+ (Class)layerClass;

- (id)initWithFrame:(CGRect)inFrame;

- (void)setNeedsLayout;
- (void)layoutIfNeeded;
- (void)layoutSubviews;

- (void)setNeedsDisplay;

@property (nonatomic, readonly) CZView *superview;
- (void)addSubview:(CZView *)inSubview;
- (void)removeFromSuperview;

@property (nonatomic, readonly, copy) NSArray *subviews;

@property(nonatomic,readonly,retain)                 CALayer  *layer;              // returns view's layer. Will always return a non-nil value. view is layer's delegate


@end

@interface CZView (CZViewActionRecognizers)
@property (nonatomic, retain, readonly) NSArray *actionRecognizers;
- (void)addActionRecognizer:(CZActionRecognizer *)actionRecognizer;
- (void)removeActionRecognizer:(CZActionRecognizer *)actionRecognizer;
@end

@interface CZView(CZViewGeometry)

// animatable. do not use frame if view is transformed since it will not correctly reflect the actual location of the view. use bounds + center instead.
@property(nonatomic) CGRect            frame;

// use bounds/center and not frame if non-identity transform. if bounds dimension is odd, center may be have fractional part
@property(nonatomic) CGRect            bounds;      // default bounds is zero origin, frame size. animatable
@property(nonatomic) CGPoint           center;      // center is center of frame. animatable
@property(nonatomic) CGAffineTransform transform;   // default is CGAffineTransformIdentity. animatable
//@property(nonatomic) CGFloat           contentScaleFactor __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_0);

//@property(nonatomic,getter=isMultipleTouchEnabled) BOOL multipleTouchEnabled;   // default is NO
//@property(nonatomic,getter=isExclusiveTouch) BOOL       exclusiveTouch;         // default is NO

- (CZView *)hitTest:(CGPoint)point withEvent:(NSEvent *)event;   // recursively calls -pointInside:withEvent:. point is in frame coordinates
- (BOOL)pointInside:(CGPoint)point withEvent:(NSEvent *)event;   // default returns YES if point is in bounds

- (CGPoint)convertPoint:(CGPoint)point toView:(CZView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromView:(CZView *)view;
- (CGRect)convertRect:(CGRect)rect toView:(CZView *)view;
- (CGRect)convertRect:(CGRect)rect fromView:(CZView *)view;

//@property(nonatomic) BOOL               autoresizesSubviews; // default is YES. if set, subviews are adjusted according to their autoresizingMask if self.bounds changes
@property(nonatomic) CZViewAutoresizing autoresizingMask;    // simple resize. default is CZViewAutoresizingNone

- (CGSize)sizeThatFits:(CGSize)size;     // return 'best' size to fit given size. does not actually resize view. Default is return existing view size
- (void)sizeToFit;                       // calls sizeThatFits: with current view bounds and changes bounds size.

@end

@interface CZView(CZViewRendering)

- (void)drawRect:(CGRect)rect __attribute__((unused));

- (void)setNeedsDisplay;
- (void)setNeedsDisplayInRect:(CGRect)rect;

@property(nonatomic)                 BOOL              clipsToBounds;              // When YES, content and subviews are clipped to the bounds of the view. Default is NO.
@property(nonatomic,copy)            CZColor          *backgroundColor;            // default is nil
@property(nonatomic)                 CGFloat           alpha;                      // animatable. default is 1.0
@property(nonatomic,getter=isOpaque) BOOL              opaque;                     // default is YES. opaque views must fill their entire bounds or the results are undefined. the active CGContext in drawRect: will not have been cleared and may have non-zeroed pixels
//TODO:@property(nonatomic)                 BOOL              clearsContextBeforeDrawing; // default is YES. ignored for opaque views. for non-opaque views causes the active CGContext in drawRect: to be pre-filled with transparent pixels
@property(nonatomic,getter=isHidden) BOOL              hidden;                     // default is NO. doesn't check superviews
@property(nonatomic)                 CZViewContentMode contentMode;                // default is CZViewContentModeScaleToFill
//@property(nonatomic)                 CGRect            contentStretch __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0); // animatable. default is unit rectangle {{0,0} {1,1}}

@end

@interface CZView(CZViewAnimationWithBlocks)

+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(CZViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion; // delay = 0.0, options = 0

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations; // delay = 0.0, options = 0, completion = NULL

+ (void)transitionWithView:(CZView *)view duration:(NSTimeInterval)duration options:(CZViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

+ (void)transitionFromView:(CZView *)fromView toView:(CZView *)toView duration:(NSTimeInterval)duration options:(CZViewAnimationOptions)options completion:(void (^)(BOOL finished))completion; // toView added to fromView.superview, fromView removed from its superview
#endif
@end