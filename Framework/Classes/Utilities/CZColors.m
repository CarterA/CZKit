//
//  CZColors.m
//  CZKit
//
//  Created by Carter Allen on 6/15/10.
//  Copyright 2010 Opt-6 Products, LLC. All rights reserved.
//

#import "CZColors.h"

CZHSBColor CZColorsHSBColorMake(CGFloat hueComponent, CGFloat saturationComponent, CGFloat brightnessComponent) {
	CZHSBColor hsbColor;
	hsbColor.hueComponent = hueComponent;
	hsbColor.saturationComponent = saturationComponent;
	hsbColor.brightnessComponent = brightnessComponent;
	return hsbColor;
}
CZRGBColor CZColorsRGBColorMake(CGFloat redComponent, CGFloat greenComponent, CGFloat blueComponent) {
	CZRGBColor rgbColor;
	rgbColor.redComponent = redComponent;
	rgbColor.greenComponent = greenComponent;
	rgbColor.blueComponent = blueComponent;
	return rgbColor;
}
CZHSBColor CZColorsHSBColorFromRGBColor(CZRGBColor rgbColor) {
	CGFloat brightness, x, f;
	NSInteger i;
	
#if defined(__LP64__) && __LP64__
	x = fmin(rgbColor.redComponent, rgbColor.greenComponent);
	x = fmin(x, rgbColor.blueComponent);
	
	brightness = fmax(rgbColor.redComponent, rgbColor.greenComponent);
	brightness = fmax(brightness, rgbColor.blueComponent);	
#else
	x = fminf(rgbColor.redComponent, rgbColor.greenComponent);
	x = fminf(x, rgbColor.blueComponent);
	
	brightness = fmaxf(rgbColor.redComponent, rgbColor.greenComponent);
	brightness = fmaxf(brightness, rgbColor.blueComponent);	
#endif
	
	if (brightness == x) return CZColorsHSBColorMake(0.0f, 0.0f, brightness);
	
	f = (rgbColor.redComponent == x) ? rgbColor.greenComponent - rgbColor.blueComponent : ((rgbColor.greenComponent == x) ? rgbColor.blueComponent - rgbColor.redComponent : rgbColor.redComponent - rgbColor.greenComponent);
	i = (rgbColor.redComponent == x) ? 3 : ((rgbColor.greenComponent == x) ? 5 : 1);
	return CZColorsHSBColorMake(((i - f/(brightness - x))/6), (brightness - x)/brightness, brightness);
}
CZRGBColor CZColorsRGBColorFromHSBColor(CZHSBColor hsbColor) {
	CGFloat h = hsbColor.hueComponent * 6;
	CGFloat m, n, f;
	NSInteger i;
	if (h == 0.0f) h = 0.01f;
	if (h == 0) return CZColorsRGBColorMake(hsbColor.brightnessComponent, hsbColor.brightnessComponent, hsbColor.brightnessComponent);
#if defined(__LP64__) && __LP64__
	i = floor(h);
#else
	i = floorf(h);
#endif
	f = h - i;
	if (!(i & 1)) f = 1.0f - f;
	m = hsbColor.brightnessComponent * (1.0f - hsbColor.saturationComponent);
	n = hsbColor.brightnessComponent * (1.0f - hsbColor.saturationComponent * f);
	switch (i) {
		case 6:
		case 0: return CZColorsRGBColorMake(hsbColor.brightnessComponent, n, m);
		case 1: return CZColorsRGBColorMake(n, hsbColor.brightnessComponent, m);
		case 2: return CZColorsRGBColorMake(m, hsbColor.brightnessComponent, n);
		case 3: return CZColorsRGBColorMake(m, n, hsbColor.brightnessComponent);
		case 4: return CZColorsRGBColorMake(n, m, hsbColor.brightnessComponent);
		case 5: return CZColorsRGBColorMake(hsbColor.brightnessComponent, m, n);
	}
	return CZColorsRGBColorMake(0.0f, 0.0f, 0.0f);
}