//
//  CZProgressIndicator.h
//  Campus
//
//  Created by Carter Allen on 1/21/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

typedef struct {
	CGFloat min;
	CGFloat max;
} CZProgressRange;
static inline CZProgressRange CZProgressRangeMake(CGFloat min, CGFloat max) {
	CZProgressRange range;
	range.min = min;
	range.max = max;
	return range;
}

@interface CZProgressIndicator : NSView {}
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, assign) CZProgressRange range;
@property (nonatomic, assign) NSControlSize controlSize;
@property (nonatomic, assign) BOOL indeterminate;
- (void)start;
- (void)stop;
@end