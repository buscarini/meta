//
//  BMFColor.m
//  iExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 29/01/14.
//  Copyright (c) 2014 JMS. All rights reserved.
//

#import "BMFColor.h"

#import "BMFImage.h"

@implementation BMFColor

/*#if TARGET_OS_IPHONE

//// IPHONE

// Convenience methods for creating autoreleased colors
+ (BMFColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	return [BMFColor colorWithColor:[UIColor colorWithWhite:white alpha:alpha]];
}
	
+ (BMFColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
	return [BMFColor colorWithColor:[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha]];
}
	
+ (BMFColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return [BMFColor colorWithColor:[UIColor colorWithRed:red green:green blue:blue alpha:alpha]];
}
	
+ (BMFColor *)colorWithCGColor:(CGColorRef)cgColor {
	return [BMFColor colorWithColor:[UIColor colorWithCGColor:cgColor]];
}
	
+ (BMFColor *)colorWithPatternImage:(BMFImage *)image {
	return [BMFColor colorWithColor:[UIColor colorWithPatternImage:image.image]];
}
	
+ (BMFColor *)colorWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0) {
	return [BMFColor colorWithColor:[UIColor colorWithCIColor:ciColor]];
}
	

// Initializers for creating non-autoreleased colors
- (BMFColor *)initWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	self = [super init];
	if (self) {
		self.color = [[UIColor alloc] initWithWhite:white alpha:alpha];
	}
	return self;
}
	
- (BMFColor *)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
	self = [super init];
	if (self) {
		self.color = [[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
	}
	return self;
}
	
- (BMFColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	self = [super init];
	if (self) {
		self.color = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
	}
	return self;
}
	
- (BMFColor *)initWithCGColor:(CGColorRef)cgColor {
	self = [super init];
	if (self) {
		self.color = [[UIColor alloc] initWithCGColor:cgColor];
	}
	return self;
}
	
- (BMFColor *)initWithPatternImage:(BMFImage*)image {
	self = [super init];
	if (self) {
		self.color = [[UIColor alloc] initWithPatternImage:image.image];
	}
	return self;
}
	
- (BMFColor *)initWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0) {
	self = [super init];
	if (self) {
		self.color = [[UIColor alloc] initWithCIColor:ciColor];
	}
	return self;
}
	

// Some convenience methods to create colors.  These colors will be as calibrated as possible.
// These colors are cached.
+ (BMFColor *)blackColor {
	return [BMFColor colorWithColor:[UIColor blackColor]];
}
	
+ (BMFColor *)darkGrayColor {
	return [BMFColor colorWithColor:[UIColor darkGrayColor]];
}
	
+ (BMFColor *)lightGrayColor {
	return [BMFColor colorWithColor:[UIColor lightGrayColor]];
}
	
+ (BMFColor *)whiteColor {
	return [BMFColor colorWithColor:[UIColor whiteColor]];
}
	
+ (BMFColor *)grayColor {
	return [BMFColor colorWithColor:[UIColor grayColor]];
}
	
+ (BMFColor *)redColor {
	return [BMFColor colorWithColor:[UIColor redColor]];
}
	
+ (BMFColor *)greenColor {
	return [BMFColor colorWithColor:[UIColor greenColor]];
}
	
+ (BMFColor *)blueColor {
	return [BMFColor colorWithColor:[UIColor blueColor]];
}
	
+ (BMFColor *)cyanColor {
	return [BMFColor colorWithColor:[UIColor cyanColor]];
}
	
+ (BMFColor *)yellowColor {
	return [BMFColor colorWithColor:[UIColor yellowColor]];
}
	
+ (BMFColor *)magentaColor {
	return [BMFColor colorWithColor:[UIColor magentaColor]];
}
	
+ (BMFColor *)orangeColor {
	return [BMFColor colorWithColor:[UIColor orangeColor]];
}
	
+ (BMFColor *)purpleColor {
	return [BMFColor colorWithColor:[UIColor purpleColor]];
}
	
+ (BMFColor *)brownColor {
	return [BMFColor colorWithColor:[UIColor brownColor]];
}
	
+ (BMFColor *)clearColor {
	return [BMFColor colorWithColor:[UIColor clearColor]];
}

+ (BMFColor *) colorWithColor:(UIColor *) color {
	BMFColor *bmfColor = [BMFColor new];
	bmfColor.color = color;
	return bmfColor;
}

#else

//// MAC


// Convenience methods for creating autoreleased colors
+ (BMFColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	return [BMFColor colorWithColor:[NSColor colorWithWhite:white alpha:alpha]];
}
	
+ (BMFColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
	return [BMFColor colorWithColor:[NSColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha]];
}
	
+ (BMFColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return [BMFColor colorWithColor:[NSColor colorWithRed:red green:green blue:blue alpha:alpha]];
}
	
+ (BMFColor *)colorWithCGColor:(CGColorRef)cgColor {
	return [BMFColor colorWithColor:[NSColor colorWithCGColor:cgColor]];
}
	
+ (BMFColor *)colorWithPatternImage:(BMFImage *)image {
	return [BMFColor colorWithColor:[NSColor colorWithPatternImage:image.image]];
}
	
+ (BMFColor *)colorWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0) {
	return [BMFColor colorWithColor:[NSColor colorWithCIColor:ciColor]];
}
	

// Initializers for creating non-autoreleased colors
- (BMFColor *)initWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	self = [super init];
	if (self) {
		self.color = [NSColor colorWithWhite:white alpha:alpha];
	}
	return self;
}
	
- (BMFColor *)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
	self = [super init];
	if (self) {
		self.color = [NSColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
	}
	return self;
}
	
- (BMFColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	self = [super init];
	if (self) {
		self.color = [NSColor colorWithRed:red green:green blue:blue alpha:alpha];
	}
	return self;
}
	
- (BMFColor *)initWithCGColor:(CGColorRef)cgColor {
	self = [super init];
	if (self) {
		self.color = [NSColor colorWithCGColor:cgColor];
	}
	return self;
}
	
- (BMFColor *)initWithPatternImage:(BMFImage*)image {
	self = [super init];
	if (self) {
		self.color = [NSColor colorWithPatternImage:image.image];
	}
	return self;
}
	
- (BMFColor *)initWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0) {
	self = [super init];
	if (self) {
		self.color = [NSColor colorWithCIColor:ciColor];
	}
	return self;
}
	

// Some convenience methods to create colors.  These colors will be as calibrated as possible.
// These colors are cached.
+ (BMFColor *)blackColor {
	return [BMFColor colorWithColor:[NSColor blackColor]];
}
	
+ (BMFColor *)darkGrayColor {
	return [BMFColor colorWithColor:[NSColor darkGrayColor]];
}
	
+ (BMFColor *)lightGrayColor {
	return [BMFColor colorWithColor:[NSColor lightGrayColor]];
}
	
+ (BMFColor *)whiteColor {
	return [BMFColor colorWithColor:[NSColor whiteColor]];
}
	
+ (BMFColor *)grayColor {
	return [BMFColor colorWithColor:[NSColor grayColor]];
}
	
+ (BMFColor *)redColor {
	return [BMFColor colorWithColor:[NSColor redColor]];
}
	
+ (BMFColor *)greenColor {
	return [BMFColor colorWithColor:[NSColor greenColor]];
}
	
+ (BMFColor *)blueColor {
	return [BMFColor colorWithColor:[NSColor blueColor]];
}
	
+ (BMFColor *)cyanColor {
	return [BMFColor colorWithColor:[NSColor cyanColor]];
}
	
+ (BMFColor *)yellowColor {
	return [BMFColor colorWithColor:[NSColor yellowColor]];
}
	
+ (BMFColor *)magentaColor {
	return [BMFColor colorWithColor:[NSColor magentaColor]];
}
	
+ (BMFColor *)orangeColor {
	return [BMFColor colorWithColor:[NSColor orangeColor]];
}
	
+ (BMFColor *)purpleColor {
	return [BMFColor colorWithColor:[NSColor purpleColor]];
}
	
+ (BMFColor *)brownColor {
	return [BMFColor colorWithColor:[NSColor brownColor]];
}
	
+ (BMFColor *)clearColor {
	return [BMFColor colorWithColor:[NSColor clearColor]];
}

+ (BMFColor *) colorWithColor:(NSColor *) color {
	BMFColor *bmfColor = [BMFColor new];
	bmfColor.color = color;
	return bmfColor;
}

#endif*/

@end
