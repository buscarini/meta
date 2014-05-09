//
//  BMFUtils.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 20/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFUtils.h"

#import <QuartzCore/QuartzCore.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#if !TARGET_OS_IPHONE
#import <WebKit/WebKit.h>
#endif

#import <CommonCrypto/CommonDigest.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/xattr.h>

#import <Base32/MF_Base32Additions.h>

static NSString *webUserAgent = nil;

@implementation BMFUtils

+ (NSData *) makePDFFrom:(BMFIXView *) view {
	
    NSData *pdfData = nil;
	
#if TARGET_OS_IPHONE
	
	NSMutableData *data = [NSMutableData data];
	
    UIGraphicsBeginPDFContextToData(data, view.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:pdfContext];
    UIGraphicsEndPDFContext();
	
	pdfData = data;
	
#else
	pdfData = [view dataWithPDFInsideRect:[view frame]];
	
#endif
	
    return pdfData;
}

+ (NSURL *)applicationSandboxStoresDirectory {
    NSURL *storesDirectory = [NSURL fileURLWithPath:[self applicationDocumentsDirectory]];
    storesDirectory = [storesDirectory URLByAppendingPathComponent:@"SharedCoreDataStores"];
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    if (NO == [fm fileExistsAtPath:[storesDirectory path]]) {
        //create it
        NSError *error = nil;
        BOOL createSuccess = [fm createDirectoryAtURL:storesDirectory
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
        if (createSuccess == NO) {
            NSLog(@"Unable to create application sandbox stores directory: %@\n\tError: %@", storesDirectory, error);
        }
    }
    return storesDirectory;
}


+ (NSString *)applicationDocumentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	return basePath;
}

+ (NSString *)applicationCacheDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	return basePath;
}

+ (BOOL) isRetinaDisplay {
#if TARGET_OS_IPHONE
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2){
		return YES;
	}
	
#else
	if ([[NSScreen mainScreen] backingScaleFactor] == 2.0f) return YES;
#endif
	
	return NO;
}

+ (NSString *) escapeURLString: (NSString *)url {
	
	id charSetClass = [NSCharacterSet class];
	if ([charSetClass respondsToSelector:@selector(URLQueryAllowedCharacterSet)]) {
		return [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
	}
	
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
																							 (CFStringRef)url,
																							 NULL,
																							 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																							 kCFStringEncodingUTF8 ));
	
	return result;
}

+ (NSString *) unescapeURLString: (NSString *)url {
	id charSetClass = [NSCharacterSet class];
	if ([charSetClass respondsToSelector:@selector(URLQueryAllowedCharacterSet)]) {
		return [url stringByRemovingPercentEncoding];
	}
	
	return [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *) htmlWithDefaultStyle:(NSString *) htmlString {
	return [self htmlWithDefaultStyle:htmlString fontSize:-1];
}

+ (NSString *) escapePathString: (NSString *)url {
	return [url base32String];
}

+ (NSString *) unescapePathString: (NSString *)url {
	return [NSString stringFromBase32String:url];
}

+ (NSString *) htmlWithDefaultStyle:(NSString *) htmlString fontSize:(NSInteger) fontSize {
	if ([htmlString rangeOfString:@"/body"].location==NSNotFound) {
		NSMutableString *result = [NSMutableString string];
		[result appendString:@"<html><head><style>body { font-family: helvetica;"];
		
		if (fontSize>0) {
			[result appendFormat:@"font-size: %ld pt;",(long)fontSize];
		}
		
		[result appendString:@" }</style></head><body>"];
		[result appendString:htmlString];
		[result appendString:@"</body></html>"];
		
		return result;
	}
	
	return htmlString;
}

+ (NSURL *) tmpFileUrl {
	NSString *cachesPath = [self applicationCacheDirectory];
	NSUUID *uuid = [NSUUID UUID];
	return [NSURL fileURLWithPathComponents:@[ cachesPath, uuid.UUIDString ] ];
}

+ (NSInteger) randomInteger:(NSInteger) minIndex max:(NSInteger) maxIndex {
	BMFAssertReturnZero(minIndex<maxIndex);
	
	uint32_t random = arc4random_uniform(maxIndex-minIndex+1);
	return random+minIndex;
}

+ (double) randomDouble:(double) minIndex max:(double) maxIndex {
	BMFAssertReturnZero(minIndex<maxIndex);
	
	float diff = maxIndex - minIndex;
	return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + minIndex;
}


+ (RACSignal *) webViewUserAgent:(NSURL *) url {
	return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
			@autoreleasepool {
				static NSString *webViewAgent = nil;
				if (!webViewAgent) {
					dispatch_sync(dispatch_get_main_queue(), ^{
						#if TARGET_OS_IPHONE
						UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
						webViewAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
						#else
						WebView *webView = [[WebView alloc] initWithFrame:CGRectZero];
						webViewAgent = [webView userAgentForURL:url];
						#endif
					});
				}
				[subscriber sendNext:webViewAgent];
				[subscriber sendCompleted];
			}
		return nil;
	}] publish] autoconnect];
}

+ (BOOL) markFileSkipBackup: (NSURL *)url {
    const char* filePath = [[url path] fileSystemRepresentation];
	
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
	
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

+ (NSString*) sha1:(NSString*)input {
	const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data = [NSData dataWithBytes:cstr length:input.length];
	
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
	
	CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
	
	NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
	
	for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
		[output appendFormat:@"%02x", digest[i]];
	}
	
	return output;
}


+ (NSString *) md5:(NSString *) input {
	const char *cStr = [input UTF8String];
	unsigned char digest[16];

	CC_MD5( cStr, (CC_LONG)strlen(cStr), digest); // This is the md5 call
	
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[output appendFormat:@"%02x", digest[i]];
	}
	
	return  output;
	
}

#if TARGET_OS_IPHONE

+ (void) showNavigationBarLoading: (UIViewController *)vc {
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	[activityIndicator startAnimating];
	UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
	
	vc.navigationItem.rightBarButtonItem = barButton;
}

+ (void) hideNavigationBarLoading: (UIViewController *)vc {
	vc.navigationItem.rightBarButtonItem = nil;
}

+ (NSString *) uniqueDeviceIdentifier {
	NSString *uuid = nil;
	
	uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
	
	return uuid;
}

+ (UIImage *) imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
	
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
    return img;
}

#endif

@end
