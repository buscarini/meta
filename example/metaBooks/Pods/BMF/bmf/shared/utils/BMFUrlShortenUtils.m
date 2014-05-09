//
//  BMFUrlShortenUtils.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 17/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFUrlShortenUtils.h"

#import "BMFUtils.h"
#import "BMFLoaderOperation.h"
#import "BMFAFURLSessionLoader.h"
#import "BMFHTMLUtils.h"
#import "BMF.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACDelegateProxy.h>

static BMFHTMLUtils *htmlUtils = nil;

@implementation BMFUrlResult
@end

@interface BMFUrlShortenUtils() <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, copy) BMFCompletionBlock completionBlock;
@property (nonatomic, strong) NSURL *currentUrl;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSSet *types;
@end

@implementation BMFUrlShortenUtils

+ (void) initialize {
	htmlUtils = [BMFHTMLUtils new];
}

- (void) recover:(NSURL *) url completion:(BMFCompletionBlock) completionBlock followRedirects:(BOOL)followRedirects acceptableContentTypes:(NSSet *) types {
	
	if (!url) {
		if (completionBlock) completionBlock(nil,[NSError errorWithDomain:@"URL" code:BMFErrorLacksRequiredData userInfo: @{ NSLocalizedDescriptionKey : @"Url should not be nil" } ]);
		return;
	}
	
	self.completionBlock = completionBlock;
	self.types = types;
	
	[[BMFUtils webViewUserAgent:url] subscribeNext:^(NSString *userAgent) {
		@autoreleasepool {
			BMFAFURLSessionLoader *loader = [[BMFAFURLSessionLoader alloc] init];
			loader.url = url;
			loader.userAgent = userAgent;
			loader.acceptableContentTypes = types;
			BMFLoaderOperation *loaderOp = [[BMFLoaderOperation alloc] initWithLoader:loader];
			__weak BMFLoaderOperation *wop = loaderOp;
			loaderOp.completionBlock = ^() {
				@autoreleasepool {
					BMFAFURLSessionLoader *sessionLoader = wop.loader;
					
					NSString *htmlString = [[NSString alloc] initWithData:wop.output encoding:NSUTF8StringEncoding];
					NSString *redirectUrl = [htmlUtils findRefresh:htmlString];
					if (redirectUrl) {
						return [self recover:[NSURL URLWithString:redirectUrl] completion:completionBlock followRedirects:followRedirects acceptableContentTypes:types];
					}
					
					BMFUrlResult *result = [BMFUrlResult new];
					result.url = sessionLoader.finalUrl;
					result.data = wop.output;
					completionBlock(result,wop.progress.failedError);
				}
			};
			
			[[BMFBase sharedInstance].networkQueue addOperation:loaderOp];

		}
	} error:^(NSError *error) {
		DDLogError(@"Error getting web view user agent: %@",error);
	}];
	
	/*BMFOperation *inputOp = [BMFOperation new];
	inputOp.output = url;
	BMFWebViewLoadOperation *loadOp = [BMFWebViewLoadOperation new];
	[loadOp addDependency:inputOp];
	__weak BMFWebViewLoadOperation *wloadOp = loadOp;
	loadOp.completionBlock = ^() {
		if (completionBlock) completionBlock(wloadOp.output,wloadOp.progress.failedError);
	};
	[urlOperationsQueue addOperations:@[ inputOp, loadOp ] waitUntilFinished:NO];*/
	
	/*BMFBlockOperation *op = [[BMFBlockOperation alloc] initWithBlock:^(id sender,BMFCompletionBlock opCompletionBlock) {
		dispatch_async(dispatch_get_main_queue(), ^{
			UIWebView* webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
			NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
			[webView loadRequest:request];
			
			webView.delegate = self;
			
//			RACDelegateProxy *delegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UIWebViewDelegate)];
//			webView.delegate = delegate;
//			
//			[[[delegate rac_signalForSelector:@selector(webViewDidStartLoad:) fromProtocol:@protocol(UIWebViewDelegate)] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//				DDLogInfo(@"did start load");
//			}];
//			
//			[[[delegate rac_signalForSelector:@selector(webViewDidFinishLoad:) fromProtocol:@protocol(UIWebViewDelegate)] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//				BMFUrlResult *result = [BMFUrlResult new];
//				result.url = webView.request.mainDocumentURL;
//				result.htmlString = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
//				completionBlock(result,nil);
//				if (opCompletionBlock) opCompletionBlock(result,nil);
//			}];
//			
//			[[[delegate rac_signalForSelector:@selector(webView:didFailLoadWithError:) fromProtocol:@protocol(UIWebViewDelegate)] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSError *error) {
//				completionBlock(nil,error);
//				if (opCompletionBlock) opCompletionBlock(nil,error);
//			}];
		});
	}];

	*/
	//[urlOperationsQueue addOperation:op];
	
	/*self.currentUrl = url;
	self.completionBlock = completionBlock;
	self.types = types;
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	
	[[[BMFUtils webViewUserAgent] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
		NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
		[connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
		[connection start];
	} error:^(NSError *error) {
		DDLogError(@"Error getting web view user agent: %@",error);
	}];*/
}
	 
#pragma mark NSURLConnectionDelegate
/*
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//	DDLogInfo(@"did fail");
	if (self.completionBlock) self.completionBlock(nil,error);
}
	 
//- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
////	DDLogInfo(@"will send");
//	if (response) {
//		self.currentUrl = response.URL;
//	}
//	return request;
//}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//	DDLogInfo(@"receive response");
	//[connection cancel];
//	DDLogInfo(@"mime type: %@",response.MIMEType);
	if ([self.types containsObject:response.MIMEType]) {
		[connection cancel];
		if (self.completionBlock) self.completionBlock(nil,[NSError errorWithDomain:@"URL" code:BMFErrorFiltered userInfo:@{ NSLocalizedDescriptionKey : @"Filtered mime type" }]);
		return;
	}
	
	self.currentUrl = response.URL;
//	if (self.completionBlock) self.completionBlock(self.currentUrl,nil);
	self.data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//	DDLogInfo(@"receive data");
//	[connection cancel];
//	if (self.completionBlock) self.completionBlock(self.currentUrl,nil);
	[self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//	DDLogInfo(@"did finish");
	BMFUrlResult *result = [BMFUrlResult new];
	result.url = self.currentUrl;
	result.data = self.data;
	if (self.completionBlock) self.completionBlock(result,nil);
}*/

@end
