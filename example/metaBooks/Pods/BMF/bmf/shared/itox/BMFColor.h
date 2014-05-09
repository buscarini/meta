//
//  BMFColor.h
//  iExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 29/01/14.
//  Copyright (c) 2014 JMS. All rights reserved.
//

#import "BMFPlatform.h"

@class BMFImage;

#if TARGET_OS_IPHONE
@interface BMFColor : UIColor
#else
@interface BMFColor : NSColor
#endif

/*// Convenience methods for creating autoreleased colors
+ (BMFColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+ (BMFColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
+ (BMFColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (BMFColor *)colorWithCGColor:(CGColorRef)cgColor;
+ (BMFColor *)colorWithPatternImage:(BMFImage *)image;
+ (BMFColor *)colorWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0);

// Initializers for creating non-autoreleased colors
- (BMFColor *)initWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
- (BMFColor *)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
- (BMFColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (BMFColor *)initWithCGColor:(CGColorRef)cgColor;
- (BMFColor *)initWithPatternImage:(BMFImage*)image;
- (BMFColor *)initWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0);

// Some convenience methods to create colors.  These colors will be as calibrated as possible.
// These colors are cached.
+ (BMFColor *)blackColor;      // 0.0 white
+ (BMFColor *)darkGrayColor;   // 0.333 white
+ (BMFColor *)lightGrayColor;  // 0.667 white
+ (BMFColor *)whiteColor;      // 1.0 white
+ (BMFColor *)grayColor;       // 0.5 white
+ (BMFColor *)redColor;        // 1.0, 0.0, 0.0 RGB
+ (BMFColor *)greenColor;      // 0.0, 1.0, 0.0 RGB
+ (BMFColor *)blueColor;       // 0.0, 0.0, 1.0 RGB
+ (BMFColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB
+ (BMFColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB
+ (BMFColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB
+ (BMFColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB
+ (BMFColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB
+ (BMFColor *)brownColor;      // 0.6, 0.4, 0.2 RGB
+ (BMFColor *)clearColor;      // 0.0 white, 0.0 alpha

#if TARGET_OS_IPHONE

@property (nonatomic, strong) UIColor *color;
+ (BMFColor *) colorWithColor:(UIColor *) color;

#else

@property (nonatomic, strong) NSColor *color;
+ (BMFColor *) colorWithColor:(NSColor *) color;

#endif*/

@end
