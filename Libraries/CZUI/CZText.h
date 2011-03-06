//
//  CZText.h
//  CZKit
//
//  Created by Carter Allen on 2/12/11.
//  Copyright 2011 Opt-6 Products, LLC. All rights reserved.
//

typedef enum {		
    CZLineBreakModeWordWrap = 0,            // Wraps text
    CZLineBreakModeCharacterWrap,           // Same as calling CZLineBreakModeWordWrap for right now -- different behavior than the iPhone
    CZLineBreakModeClip,                    // Simply clip when it hits the end of the rect
    CZLineBreakModeHeadTruncation,          // Truncate at head of line: "...wxyz". Will truncate multiline text on first line
    CZLineBreakModeTailTruncation,          // Truncate at tail of line: "abcd...". Will truncate multiline text on last line
    CZLineBreakModeMiddleTruncation,        // Truncate middle of line:  "ab...yz". Will truncate multiline text in the middle
} CZLineBreakMode;

typedef enum {
    CZTextAlignmentLeft = 0,
    CZTextAlignmentCenter,
    CZTextAlignmentRight,
	
	// As of iPhone OS 3.1.2 these are not available on the iPhone
	CZTextAlignmentJusitifed, 
	CZTextAlignmentNatural
} CZTextAlignment;

typedef enum {
    CZBaselineAdjustmentAlignBaselines = 0, // default. used when shrinking text to position based on the original baseline
    CZBaselineAdjustmentAlignCenters,
    CZBaselineAdjustmentNone,
} CZBaselineAdjustment;