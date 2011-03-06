//
//  CZView.m
//  CZKit
//
//  Created by Carter Allen on 1/2/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZView.h"
#import "CZView-Private.h"
#import "CZViewController.h"
#import "CZGraphics.h"
#import "CZColor.h"
#import "CZActionRecognizer.h"
#import "CZActionRecognizerSubclass.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#if !TARGET_OS_IPHONE

@interface CZView () {
	CALayer *layer;
	CZViewController *viewDelegate;
	//TODO: why don't other implementations have this, ie how do they retain the views?
	NSMutableArray *subviews;
	struct {
        unsigned int implementsDrawRect:1;
		//        unsigned int hasBackgroundColor:1;
		//        unsigned int isOpaque:1;
        unsigned int needsDisplayOnBoundsChange:1;
    } _viewFlags;
}
@property (nonatomic, readwrite, retain) CALayer *layer;
@property (nonatomic, retain) NSArray *actionRecognizers;
- (void)_updateNextResponder;
@end

#endif

@implementation CZView

#if !TARGET_OS_IPHONE

#pragma mark -
@synthesize layer=_layer;
@synthesize viewDelegate;
@synthesize subviews;
@synthesize actionRecognizers=_actionRecognizers;
@synthesize userInteractionEnabled=_userInteractionEnabled;

#pragma mark -
#pragma mark Initializers
+ (Class)layerClass {
	return [CALayer class];
}

- (id)initWithFrame:(CGRect)inFrame {
	self = [super init];
	if (!self) return nil;
	
	self.layer = [[[[self class] layerClass] alloc] init];
	self.layer.delegate = self;
	subviews = [[NSMutableArray alloc] init];
	
	self.userInteractionEnabled = YES;
	
	self.contentMode = CZViewContentModeScaleToFill;
	_viewFlags.implementsDrawRect = [self respondsToSelector:@selector(drawRect:)];
	
	[self setFrame:inFrame];
	
	return self;
}

- (void) dealloc {
	layer.delegate = nil;
	[layer release];
	[subviews release];
	[super dealloc];
}

- (void)setNeedsLayout { [self.layer setNeedsLayout]; }

- (void)layoutIfNeeded { [self.layer layoutIfNeeded]; }

- (void)layoutSubviews {
	//TODO: auto-sizing?
}

- (void)setNeedsDisplay {
	[layer setNeedsDisplay];
}

- (void)addSubview:(CZView *)subview {
	//TODO: do this better
	[subviews addObject:subview];
	[layer addSublayer:subview.layer];
	[subview _updateNextResponder];
}

- (CZView *)superview {
	CZView *superview = [layer superlayer].delegate;
	return superview;	
}

- (void)removeFromSuperview {
	CZView *superview = self.superview;
	if (superview) [superview->subviews removeObject:self];
	[self.layer removeFromSuperlayer];
	[self _updateNextResponder];
}

- (void)setViewDelegate:(CZViewController *)inViewController {
	viewDelegate = inViewController;
	[self _updateNextResponder];
}

- (BOOL)acceptsFirstResponder { return YES; }

- (void)_updateNextResponder {
	if (viewDelegate) {
		[self setNextResponder:viewDelegate];
		[viewDelegate setNextResponder:self.superview];
	}
	else [self setNextResponder:self.superview];
}

@end

@implementation CZView (CZViewActionRecognizers)

#pragma mark -
#pragma mark Action Recognizer Manipulation
- (NSArray *)actionRecognizers {
	return _actionRecognizers;
}
- (void)addActionRecognizer:(CZActionRecognizer *)actionRecognizer {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSMutableArray *mutableActionRecognizers = [NSMutableArray arrayWithArray:self.actionRecognizers];
	[mutableActionRecognizers addObject:actionRecognizer];
	self.actionRecognizers = [NSArray arrayWithArray:mutableActionRecognizers];
	[pool release];
}
- (void)removeActionRecognizer:(CZActionRecognizer *)actionRecognizer {
	if ([self.actionRecognizers containsObject:actionRecognizer]) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		NSMutableArray *mutableActionRecognizers = [NSMutableArray arrayWithArray:self.actionRecognizers];
		[mutableActionRecognizers removeObject:actionRecognizer];
		self.actionRecognizers = [NSArray arrayWithArray:mutableActionRecognizers];
		[pool release];
	}
}

#pragma mark -
#pragma mark Event Handling for Action Recognizers
#define CZ_INTERCEPT_EVENT(eventName) \
- (void)eventName:(NSEvent *)event {\
[self.actionRecognizers makeObjectsPerformSelector:@selector(receivedEvent:) withObject:event];\
}
- (void)mouseDown:(NSEvent *)event {
	NSLog(@"mouseDown in class: %@", object_getClass(self));
}
//CZ_INTERCEPT_EVENT(mouseDown);
CZ_INTERCEPT_EVENT(mouseUp);
CZ_INTERCEPT_EVENT(mouseEntered);
CZ_INTERCEPT_EVENT(mouseExited);

@end

@implementation CZView (CZViewGeometry)

- (void)setFrame:(CGRect)inFrame {
	layer.frame = inFrame;
	if (_viewFlags.needsDisplayOnBoundsChange)
		[self setNeedsDisplay];
}
- (CGRect)frame { return layer.frame; }

- (void)setBounds:(CGRect)inBounds {
	layer.bounds = inBounds;
	if (_viewFlags.needsDisplayOnBoundsChange)
		[self setNeedsDisplay];
}

- (CGRect)bounds {
	return layer.bounds;
}

- (void)setCenter:(CGPoint)inCenter {
	self.layer.anchorPoint = inCenter;
}

- (CGPoint)center {
	return self.layer.anchorPoint;
}

- (CGAffineTransform)transform {
	CATransform3D t = layer.transform;
	if (CATransform3DIsAffine(t)) {
		return CATransform3DGetAffineTransform(t);
	} else {
		return CGAffineTransformIdentity;
	}
}

- (void)setTransform:(CGAffineTransform)inTransform {
	self.layer.transform = CATransform3DMakeAffineTransform(inTransform);
}


- (void)setAutoresizingMask:(CZViewAutoresizing)inAutoresizingMask {
	layer.autoresizingMask = inAutoresizingMask;
}

- (CZViewAutoresizing)autoresizingMask {
	return layer.autoresizingMask;
}

- (CGSize)sizeThatFits:(CGSize)size {
	return self.frame.size;
}

- (void)sizeToFit {
	CGRect newFrame = self.frame;
	newFrame.size = [self sizeThatFits:newFrame.size];
	self.frame = newFrame;
}

#pragma mark -
#pragma mark Event Handling

- (BOOL)isDescendantOfView:(CZView *)inView {
	CZView *parent = [self superview];
	while (parent && parent != inView) {
		parent = [parent superview];
	}
	return parent != nil;
}

- (CGPoint)convertPoint:(CGPoint)point fromView:(CZView *)inView {
	return [self.layer convertPoint:point fromLayer:inView.layer];
}

- (CGPoint)convertPoint:(CGPoint)point toView:(CZView *)inView {
	return [self.layer convertPoint:point toLayer:inView.layer];
}

- (CZView *)hitTest:(CGPoint)point withEvent:(NSEvent *)event {
	if ([self pointInside:point withEvent:event]) {
		for (CZView *subview in [[self subviews] reverseObjectEnumerator]) {
			if (subview.userInteractionEnabled && subview.alpha > 0.01f) {
				CGPoint subviewPoint = [self convertPoint:point toView:subview];
				CZView *foundView = [subview hitTest:subviewPoint withEvent:event];
				if (foundView) {
					return foundView;
				}
			}
		}
		return self;
	} else {
		return nil;
	}
}


- (BOOL)pointInside:(CGPoint)point withEvent:(NSEvent *)event {
	return CGRectContainsPoint(self.bounds, point);
}

#pragma mark -

- (CGRect)convertRect:(CGRect)rect toView:(CZView *)view {
	return [self.layer convertRect:rect toLayer:view.layer];
}

- (CGRect)convertRect:(CGRect)rect fromView:(CZView *)view {
	return [self.layer convertRect:rect fromLayer:view.layer];
}


#pragma mark -
#pragma mark Debug

- (NSString *)description {
	return [[super description] stringByAppendingFormat:@"{frame:%@}", NSStringFromRect(NSRectFromCGRect(self.frame))];
}

- (NSString *)_recursiveDescriptionWithLevel:(NSUInteger)inLevel {
	NSString *indent = @"";
	for (NSUInteger i = 0; i < inLevel; i++) {
		indent = [indent stringByAppendingString:@" | "];
	}
	NSString *str = [NSString stringWithFormat:@"%@%@\n", indent, [self description]];
	for (CZView *view in self.subviews) {
		str = [str stringByAppendingString:[view _recursiveDescriptionWithLevel:inLevel+1]];
	}
	return str;
}


- (NSString *)recursiveDescription {
	return [self _recursiveDescriptionWithLevel:0];
}

@end

@implementation CZView (CZViewRendering)

- (void)drawRect:(CGRect)rect {}

- (void)setNeedsDisplay { [self.layer setNeedsDisplay]; }

- (void)setNeedsDisplayInRect:(CGRect)rect { [self.layer setNeedsDisplayInRect:rect]; }

- (BOOL)clipsToBounds { return layer.masksToBounds; }

- (void)setClipsToBounds:(BOOL)inClipsToBounds { layer.masksToBounds = inClipsToBounds; }

- (CZColor *)backgroundColor { return [[[CZColor alloc] initWithCGColorRef:layer.backgroundColor] autorelease]; }

- (void)setBackgroundColor:(CZColor *)inBackgroundColor { layer.backgroundColor = [inBackgroundColor CGColor]; }

- (CGFloat)alpha { return layer.opacity; }

- (void)setAlpha:(CGFloat)inAlpha { layer.opacity = inAlpha; }

- (BOOL)isOpaque { return layer.opaque; }

- (void)setOpaque:(BOOL)inOpaque { layer.opaque = inOpaque; }

//TODO:- (BOOL)              clearsContextBeforeDrawing;

- (BOOL)isHidden {
	return layer.hidden;
}

- (void)setHidden:(BOOL)inHidden {
	layer.hidden = inHidden;
}

- (CZViewContentMode)contentMode {
	BOOL drawRectDude = _viewFlags.needsDisplayOnBoundsChange;
	if (drawRectDude) return CZViewContentModeRedraw;
	
	/*Options are `center', `top', `bottom', `left',
	 * `right', `topLeft', `topRight', `bottomLeft', `bottomRight',
	 * `resize', `resizeAspect', `resizeAspectFill'. The default value is
	 * `resize'*/
	
	if ([layer.contentsGravity isEqualToString:@"center"]) {
		return CZViewContentModeCenter;
	} else if ([layer.contentsGravity isEqualToString:@"top"]) {
		return CZViewContentModeTop;
	} else if ([layer.contentsGravity isEqualToString:@"bottom"]) {
		return CZViewContentModeBottom;
	} else if ([layer.contentsGravity isEqualToString:@"left"]) {
		return CZViewContentModeLeft;
	} else if ([layer.contentsGravity isEqualToString:@"right"]) {
		return CZViewContentModeRight;
	} else if ([layer.contentsGravity isEqualToString:@"topLeft"]) {
		return CZViewContentModeTopLeft;
	} else if ([layer.contentsGravity isEqualToString:@"topRight"]) {
		return CZViewContentModeTopRight;
	} else if ([layer.contentsGravity isEqualToString:@"bottomLeft"]) {
		return CZViewContentModeBottomLeft;
	} else if ([layer.contentsGravity isEqualToString:@"bottomRight"]) {
		return CZViewContentModeBottomRight;
	} else if ([layer.contentsGravity isEqualToString:@"resize"]) {
		return CZViewContentModeScaleToFill;
	} else if ([layer.contentsGravity isEqualToString:@"resizeAspect"]) {
		return CZViewContentModeScaleAspectFit;
	} else if ([layer.contentsGravity isEqualToString:@"resizeAspectFill"]) {
		return CZViewContentModeScaleAspectFill;
	}
	NSAssert(FALSE, @"Unknown contentsGravity on layer couldn't be mapped to a CZView contentMode");
	return CZViewContentModeScaleToFill;
}

- (void)setContentMode:(CZViewContentMode)inContentMode {
	if (inContentMode == CZViewContentModeRedraw) {
		//TODO: verify this behaviour
		layer.contentsGravity = @"resize";
	} else if (inContentMode == CZViewContentModeCenter) {
		layer.contentsGravity = @"center";
	} else if (inContentMode == CZViewContentModeTop) {
		layer.contentsGravity = @"top";
	} else if (inContentMode == CZViewContentModeBottom) {
		layer.contentsGravity = @"bottom";
	} else if (inContentMode == CZViewContentModeLeft) {
		layer.contentsGravity = @"left";
	} else if (inContentMode == CZViewContentModeRight) {
		layer.contentsGravity = @"right";
	} else if (inContentMode == CZViewContentModeTopLeft) {
		layer.contentsGravity = @"topLeft";
	} else if (inContentMode == CZViewContentModeTopRight) {
		layer.contentsGravity = @"topRight";
	} else if (inContentMode == CZViewContentModeBottomLeft) {
		layer.contentsGravity = @"bottomLeft";
	} else if (inContentMode == CZViewContentModeBottomRight) {
		layer.contentsGravity = @"bottomRight";
	} else if (inContentMode == CZViewContentModeScaleToFill) {
		layer.contentsGravity = @"resize";
	} else if (inContentMode == CZViewContentModeScaleAspectFit) {
		layer.contentsGravity = @"resizeAspect";
	} else if (inContentMode == CZViewContentModeScaleAspectFill) {
		layer.contentsGravity = @"resizeAspectFill";
	}
	_viewFlags.needsDisplayOnBoundsChange = (inContentMode == CZViewContentModeRedraw);
	
}
//TODO: How can we implement this?
//@property(nonatomic)                 CGRect            contentStretch __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0); // animatable. default is unit rectangle {{0,0} {1,1}}

@end

@interface CZViewAnimationGroup : NSObject {}
@property (nonatomic) NSTimeInterval delay;
@property (nonatomic) NSTimeInterval duration;

+ (NSMutableArray *)animationGroupStack;

+ (CZViewAnimationGroup *)currentAnimationGroup;

+ (void)begin;
+ (void)commit;

@end

@implementation CZViewAnimationGroup

@synthesize delay;
@synthesize duration;

+ (NSMutableArray *)animationGroupStack {
	static NSMutableArray *animationGroupStack;
	if (!animationGroupStack) {
		animationGroupStack = [[NSMutableArray alloc] init];
	}
	return animationGroupStack;
}

+ (CZViewAnimationGroup *)currentAnimationGroup {
	NSMutableArray *animationGroupStack = [self animationGroupStack];
	if (animationGroupStack.count > 0)return [animationGroupStack objectAtIndex:animationGroupStack.count - 1];
	else return nil;
}

+ (void)begin {
	CZViewAnimationGroup *group = [[[CZViewAnimationGroup alloc] init] autorelease];
	[[self animationGroupStack] addObject:group];
}

+ (void)commit {
	[[self animationGroupStack] removeLastObject];
}

@end

@interface CZViewAnimation : NSObject <CAAction> {}
@property (nonatomic, retain) CABasicAnimation *animation;
@end

@implementation CZViewAnimation
@synthesize animation;
- (void)runActionForKey:(NSString *)event object:(id)anObject arguments:(NSDictionary *)dict {
	CALayer *layer = (CALayer *)anObject;
	self.animation.toValue = [layer valueForKey:event];
	[layer addAnimation:animation forKey:event];
}
@end

@implementation CZView (CALayerDelegate)

- (void)layoutSublayersOfLayer:(CALayer *)inLayer { [self layoutSubviews]; }

- (void)drawLayer:(CALayer *)inLayer inContext:(CGContextRef)context {	
	CZGraphicsPushContext(context);
	if ([self respondsToSelector:@selector(drawRect:)]) {
		[self drawRect:self.bounds];
	}
	CZGraphicsPopContext();
}

- (id<CAAction>)actionForLayer:(CALayer *)inLayer forKey:(NSString *)event {
	CZViewAnimationGroup *group = [CZViewAnimationGroup currentAnimationGroup];
	if (group) {
		CZViewAnimation *viewAnimation = [[[CZViewAnimation alloc] init] autorelease];
		CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
		animation.duration = group.duration;
		animation.fromValue = [inLayer valueForKey:event];
		viewAnimation.animation = animation;
		return viewAnimation;
	} else {
		return (id)[NSNull null];		
	}
}

@end

@implementation CZView (CZViewAnimationWithBlocks)

+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(CZViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion {
	[CZViewAnimationGroup begin];
	CZViewAnimationGroup *group = [CZViewAnimationGroup currentAnimationGroup];
	group.duration = duration;
	group.delay = delay;
	[CATransaction begin];
	[CATransaction setAnimationDuration:duration];
	//TODO: delay
	if (animations)
		animations();
	
	//TODO: pass back whether we actually finished!
	if (completion) {
		[CATransaction setCompletionBlock:^{completion(YES);}];
	}
	[CATransaction commit];
	[CZViewAnimationGroup commit];
}

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion {
	[self animateWithDuration:duration delay:0.0 options:0 animations:animations completion:completion];
}

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations {
	[self animateWithDuration:duration delay:0.0 options:0 animations:animations completion:NULL];
}

+ (void)transitionWithView:(CZView *)view duration:(NSTimeInterval)duration options:(CZViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion {}

+ (void)transitionFromView:(CZView *)fromView toView:(CZView *)toView duration:(NSTimeInterval)duration options:(CZViewAnimationOptions)options completion:(void (^)(BOOL finished))completion {}

#endif // !TARGET_OS_IPHONE

@end