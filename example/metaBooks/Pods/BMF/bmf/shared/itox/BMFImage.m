//
//  BMFImage.m
//  iExample
//
//  Created by Jose Manuel Sánchez Peñarroja on 29/01/14.
//  Copyright (c) 2014 JMS. All rights reserved.
//

#import "BMFImage.h"

@implementation BMFImage

/*#if TARGET_OS_IPHONE

+ (UIImageOrientation) orientationWithOrientation:(BMFImageOrientation) orientation {
	if (orientation==BMFImageOrientationUp) return UIImageOrientationUp;
	if (orientation==BMFImageOrientationDown) return UIImageOrientationDown;
	if (orientation==BMFImageOrientationLeft) return UIImageOrientationLeft;
	if (orientation==BMFImageOrientationRight) return UIImageOrientationRight;
	if (orientation==BMFImageOrientationUpMirrored) return UIImageOrientationUpMirrored;
	if (orientation==BMFImageOrientationDownMirrored) return UIImageOrientationDownMirrored;
	if (orientation==BMFImageOrientationLeftMirrored) return UIImageOrientationLeftMirrored;
	if (orientation==BMFImageOrientationRightMirrored) return UIImageOrientationRightMirrored;
	return UIImageOrientationUp;
}

+ (BMFImage *)imageNamed:(NSString *)name {
	UIImage *image = [UIImage imageNamed:name];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithContentsOfFile:(NSString *)path {
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithData:(NSData *)data {
	UIImage *image = [[UIImage alloc] initWithData:data];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithData:(NSData *)data scale:(CGFloat)scale NS_AVAILABLE_IOS(6_0) {
	UIImage *image = [[UIImage alloc] initWithData:data scale:scale];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithCGImage:(CGImageRef)cgImage {
	UIImage *image = [[UIImage alloc] initWithCGImage:cgImage];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(BMFImageOrientation)orientation NS_AVAILABLE_IOS(4_0) {
	UIImage *image = [[UIImage alloc] initWithCGImage:cgImage scale:scale orientation:[self orientationWithOrientation:orientation]];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithCIImage:(CIImage *)ciImage NS_AVAILABLE_IOS(5_0) {
	UIImage *image = [[UIImage alloc] initWithCIImage:ciImage];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithCIImage:(CIImage *)ciImage scale:(CGFloat)scale orientation:(BMFImageOrientation)orientation NS_AVAILABLE_IOS(6_0) {
	UIImage *image = [[UIImage alloc] initWithCIImage:ciImage scale:scale orientation:[self orientationWithOrientation:orientation]];
	return [BMFImage imageWithImage:image];
}


- (id)initWithContentsOfFile:(NSString *)path {
	self = [super init];
	if (self) {
		self.image = [[UIImage alloc] initWithContentsOfFile:path];
	}
	return self;
}
	
- (id)initWithData:(NSData *)data {
	self = [super init];
	if (self) {
		self.image = [[UIImage alloc] initWithData:data];
	}
	return self;
}
	
- (id)initWithData:(NSData *)data scale:(CGFloat)scale NS_AVAILABLE_IOS(6_0) {
	self = [super init];
	if (self) {
		self.image = [[UIImage alloc] initWithData:data scale:scale];
	}
	return self;
}
	
- (id)initWithCGImage:(CGImageRef)cgImage {
	self = [super init];
	if (self) {
		self.image = [[UIImage alloc] initWithCGImage:cgImage];
	}
	return self;
}
	
- (id)initWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(BMFImageOrientation)orientation NS_AVAILABLE_IOS(4_0) {
	self = [super init];
	if (self) {
		self.image = [[UIImage alloc] initWithCGImage:cgImage scale:scale orientation:[BMFImage orientationWithOrientation:orientation]];
	}
	return self;
}
	
//- (id)initWithCIImage:(CIImage *)ciImage NS_AVAILABLE_IOS(5_0) {
//	self = [super init];
//	if (self) {
//		self.image = [[UIImage alloc] initWithCIImage:ciImage];
//	}
//	return self;
//}
//	
//- (id)initWithCIImage:(CIImage *)ciImage scale:(CGFloat)scale orientation:(BMFImageOrientation)orientation NS_AVAILABLE_IOS(6_0) {
//	self = [super init];
//	if (self) {
//		self.image = [[UIImage alloc] initWithCIImage:ciImage scale:scale orientation:[self orientationWithOrientation:orientation]];
//	}
//	return self;
//}
//	


+ (BMFImage *) imageWithImage:(UIImage *) image {
	BMFImage *resultImage = [BMFImage new];
	resultImage.image = image;
	return resultImage;
}

#else

+ (BMFImage *)imageNamed:(NSString *)name {
	NSImage *image = [NSImage imageNamed:name];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithContentsOfFile:(NSString *)path {
	NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithData:(NSData *)data {
	NSImage *image = [[NSImage alloc] initWithData:data];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithData:(NSData *)data scale:(CGFloat)scale NS_AVAILABLE_IOS(6_0) {
	NSImage *image = [[NSImage alloc] initWithData:data];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithCGImage:(CGImageRef)cgImage {
	NSImage *image = [[NSImage alloc] initWithCGImage:cgImage size:NSZeroSize];
	return [BMFImage imageWithImage:image];
}

+ (BMFImage *)imageWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(BMFImageOrientation)orientation NS_AVAILABLE_IOS(4_0) {
	return [BMFImage imageWithCGImage:cgImage];
}

//+ (BMFImage *)imageWithCIImage:(CIImage *)ciImage NS_AVAILABLE_IOS(5_0) {
//	NSImage *image = [[NSImage alloc] initWithCIImage:ciImage];
//	return [BMFImage imageWithImage:image];
//}
//
//+ (BMFImage *)imageWithCIImage:(CIImage *)ciImage scale:(CGFloat)scale orientation:(BMFImageOrientation)orientation NS_AVAILABLE_IOS(6_0) {
//	NSImage *image = [[NSImage alloc] initWithCIImage:ciImage scale:scale orientation:orientation];
//	return [BMFImage imageWithImage:image];
//}


- (id)initWithContentsOfFile:(NSString *)path {
	self = [super init];
	if (self) {
		self.image = [[NSImage alloc] initWithContentsOfFile:path];
	}
	return self;
}

- (id)initWithData:(NSData *)data {
	self = [super init];
	if (self) {
		self.image = [[NSImage alloc] initWithData:data];
	}
	return self;
}

- (id)initWithData:(NSData *)data scale:(CGFloat)scale NS_AVAILABLE_IOS(6_0) {
	self = [super init];
	if (self) {
		self.image = [[NSImage alloc] initWithData:data];
	}
	return self;
}

- (id)initWithCGImage:(CGImageRef)cgImage {
	self = [super init];
	if (self) {
		self.image = [[NSImage alloc] initWithCGImage:cgImage size:NSZeroSize];
	}
	return self;
}

- (id)initWithCGImage:(CGImageRef)cgImage scale:(CGFloat)scale orientation:(BMFImageOrientation)orientation NS_AVAILABLE_IOS(4_0) {
	self = [super init];
	if (self) {
		self.image = [[NSImage alloc] initWithCGImage:cgImage size:NSZeroSize];
	}
	return self;
}

//- (id)initWithCIImage:(CIImage *)ciImage NS_AVAILABLE_IOS(5_0) {
//	self = [super init];
//	if (self) {
//		self.image = [[NSImage alloc] initWithCIImage:ciImage];
//	}
//	return self;
//}
//
//- (id)initWithCIImage:(CIImage *)ciImage scale:(CGFloat)scale orientation:(BMFImageOrientation)orientation NS_AVAILABLE_IOS(6_0) {
//	self = [super init];
//	if (self) {
//		self.image = [[NSImage alloc] initWithCIImage:data scale:scale orientation:orientation];
//	}
//	return self;
//}


+ (BMFImage *) imageWithImage:(NSImage *) image {
	BMFImage *resultImage = [BMFImage new];
	resultImage.image = image;
	return resultImage;
}

#endif*/

#if TARGET_OS_IPHONE

+ (NSData *) BMF_jpegRepresentation:(BMFIXImage *) image quality:(CGFloat) quality {
	return UIImageJPEGRepresentation(image,quality);
}

+ (NSData *) BMF_pngRepresentation:(BMFIXImage *) image {
	return UIImagePNGRepresentation(image);
}


+ (BMFIXImage *) imageByDrawing:(BMFImageDrawBlock) drawBlock size:(CGSize) size {
	
	BMFAssertReturnNil(drawBlock);
	
	UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
	
	drawBlock();
	
	UIImage *drewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return drewImage;
}

+ (BMFIXImage *) imageWithView:(BMFIXView *)view {
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
	
	if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
		[view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
	}
	else {
		[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	}
		
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
    return img;
}

#else

+ (NSData *) BMF_jpegRepresentation:(BMFIXImage *) image quality:(CGFloat) quality {
	NSBitmapImageRep *rep = image.representations[0];
	return [rep representationUsingType:NSJPEGFileType properties:@{ NSImageCompressionFactor : @(quality) }];
}

+ (NSData *) BMF_pngRepresentation:(BMFIXImage *) image {
	NSBitmapImageRep *rep = image.representations[0];
	return [rep representationUsingType:NSPNGFileType properties:nil];
}


+ (BMFImage *)imageWithContentsOfFile:(NSString *)path {
	return [[BMFImage alloc] initWithContentsOfFile:path];
}

+ (BMFImage *)imageWithData:(NSData *)data {
	return [BMFImage imageWithData:data scale:1.0f];
}

+ (BMFImage *)imageWithData:(NSData *)data scale:(CGFloat)scale {
	return [[BMFImage alloc] initWithData:data];
}

+ (BMFIXImage *) imageByDrawing:(BMFImageDrawBlock) drawBlock size:(CGSize) size {
	
	BMFAssertReturnNil(drawBlock);
	
	NSImage* image = [[NSImage alloc] initWithSize:NSMakeSize(size.width,size.height)];
	[image lockFocus];

	drawBlock();
	
	[image unlockFocus];
	
	return image;
}

+ (BMFIXImage *) imageWithView:(BMFIXView *)view {
	NSSize mySize = view.bounds.size;
	NSSize imgSize = NSMakeSize( mySize.width, mySize.height );
	
	NSBitmapImageRep *brep = [view bitmapImageRepForCachingDisplayInRect:view.bounds];
	[brep setSize:imgSize];
	[view cacheDisplayInRect:view.bounds toBitmapImageRep:brep];
	
	NSImage *image = [[NSImage alloc] initWithSize:imgSize];
	[image addRepresentation:brep];
	
	return image;
}


#endif



@end
