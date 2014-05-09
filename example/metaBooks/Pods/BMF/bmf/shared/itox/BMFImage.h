//
//  BMFImage.h
//  iExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 29/01/14.
//  Copyright (c) 2014 JMS. All rights reserved.
//

#import "BMFPlatform.h"

#import "BMFTypes.h"

typedef void(^BMFImageDrawBlock)();

#if TARGET_OS_IPHONE
@interface BMFImage : UIImage
#else 
@interface BMFImage : NSImage
#endif

typedef NS_ENUM(NSInteger, BMFImageOrientation) {
    BMFImageOrientationUp,            // default orientation
    BMFImageOrientationDown,          // 180 deg rotation
    BMFImageOrientationLeft,          // 90 deg CCW
    BMFImageOrientationRight,         // 90 deg CW
    BMFImageOrientationUpMirrored,    // as above but image mirrored along other axis. horizontal flip
    BMFImageOrientationDownMirrored,  // horizontal flip
    BMFImageOrientationLeftMirrored,  // vertical flip
    BMFImageOrientationRightMirrored, // vertical flip
};

//+ (NSData *) BMF_jpegRepresentation:(BMFImage *) image quality:(CGFloat) quality;

+ (NSData *) BMF_jpegRepresentation:(BMFIXImage *) image quality:(CGFloat) quality;
+ (NSData *) BMF_pngRepresentation:(BMFIXImage *) image;

+ (BMFIXImage *) imageByDrawing:(BMFImageDrawBlock) drawBlock size:(CGSize) size;
+ (BMFIXImage *) imageWithView:(BMFIXView *)view;


#if !TARGET_OS_IPHONE
+ (BMFImage *)imageWithContentsOfFile:(NSString *)path;
+ (BMFImage *)imageWithData:(NSData *)data;
+ (BMFImage *)imageWithData:(NSData *)data scale:(CGFloat)scale;

#endif

@end
