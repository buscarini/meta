//
//  BMFUtils.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 20/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFPlatform.h"

#import "BMFTypes.h"

@class RACSignal;

@interface BMFUtils : NSObject

+ (NSData *) makePDFFrom:(BMFIXView *) view;

+ (NSURL *)applicationSandboxStoresDirectory;
+ (NSString *)applicationDocumentsDirectory;
+ (NSString *)applicationCacheDirectory;
+ (BOOL) isRetinaDisplay;

+ (NSString *) escapeURLString: (NSString *)url;
+ (NSString *) unescapeURLString: (NSString *)url;

+ (NSString *) escapePathString: (NSString *)url;
+ (NSString *) unescapePathString: (NSString *)url;

+ (NSString *) htmlWithDefaultStyle:(NSString *) htmlString;
+ (NSString *) htmlWithDefaultStyle:(NSString *) htmlString fontSize:(NSInteger) fontSize;

+ (NSURL *) tmpFileUrl;

+ (NSInteger) randomInteger:(NSInteger) minIndex max:(NSInteger) maxIndex;
+ (double) randomDouble:(double) minIndex max:(double) maxIndex;

+ (RACSignal *) webViewUserAgent:(NSURL *) url;

#if TARGET_OS_IPHONE
+ (void) showNavigationBarLoading: (UIViewController *)vc;
+ (void) hideNavigationBarLoading: (UIViewController *)vc;

+ (NSString *) uniqueDeviceIdentifier;

+ (BOOL) markFileSkipBackup: (NSURL *)url;

+ (NSString*) sha1:(NSString*)input;
+ (NSString *) md5:(NSString *) input;

+ (UIImage *) imageWithView:(UIView *)view;

#endif

@end
