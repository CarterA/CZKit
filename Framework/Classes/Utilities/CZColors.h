//
//  CZColors.h
//  CZKit
//
//  Created by Carter Allen on 6/15/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

typedef struct {
	CGFloat hueComponent;
	CGFloat saturationComponent;
	CGFloat brightnessComponent;
} CZHSBColor;

typedef struct {
	CGFloat redComponent;
	CGFloat greenComponent;
	CGFloat blueComponent;
} CZRGBColor;

CZHSBColor CZHSBColorCreate(CGFloat hueComponent, CGFloat saturationComponent, CGFloat brightnessComponent);
CZRGBColor CZRGBColorCreate(CGFloat redComponent, CGFloat greenComponent, CGFloat blueComponent);
CZHSBColor CZHSBColorCreateFromRGBColor(CZRGBColor rgbColor);
CZRGBColor CZRGBColorCreateFromHSBColor(CZHSBColor hsbColor);