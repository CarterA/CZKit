//
//  CZScrollView.h
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

#import "CZMacros.h"
#import "CZView.h"

@protocol CZScrollViewDelegate;

@interface CZScrollView : CZ_DYNAMIC_TYPE(CZView, UIScrollView) {}
#if !TARGET_OS_IPHONE
@property (nonatomic, assign) id <CZScrollViewDelegate> delegate;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, readonly, retain) CZView *contentView;
#endif
@end

#if TARGET_OS_IPHONE
@protocol CZScrollViewDelegate <NSObject, UIScrollViewDelegate>
#else
@protocol CZScrollViewDelegate <NSObject>
#endif

@optional

- (void)scrollViewDidScroll:(CZScrollView *)scrollView;                                               // any offset changes
//- (void)scrollViewDidZoom:(CZScrollView *)scrollView __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_2); // any zoom scale changes

- (void)scrollViewWillBeginDragging:(CZScrollView *)scrollView;                              // called on start of dragging (may require some time and or distance to move)
- (void)scrollViewDidEndDragging:(CZScrollView *)scrollView willDecelerate:(BOOL)decelerate; // called on finger up if user dragged. decelerate is true if it will continue moving afterwards

- (void)scrollViewWillBeginDecelerating:(CZScrollView *)scrollView;   // called on finger up as we are moving
- (void)scrollViewDidEndDecelerating:(CZScrollView *)scrollView;      // called when scroll view grinds to a halt

- (void)scrollViewDidEndScrollingAnimation:(CZScrollView *)scrollView; // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating

//- (CZView *)viewForZoomingInScrollView:(CZScrollView *)scrollView;     // return a view that will be scaled. if delegate returns nil, nothing happens
//- (void)scrollViewWillBeginZooming:(CZScrollView *)scrollView withView:(CZView *)view __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_2); // called before the scroll view begins zooming its content
//- (void)scrollViewDidEndZooming:(CZScrollView *)scrollView withView:(CZView *)view atScale:(float)scale; // scale between minimum and maximum. called after any 'bounce' animations
//
//- (BOOL)scrollViewShouldScrollToTop:(CZScrollView *)scrollView;   // return a yes if you want to scroll to the top. if not defined, assumes YES
//- (void)scrollViewDidScrollToTop:(CZScrollView *)scrollView;      // called when scrolling animation finished. may be called immediately if already at top

@end