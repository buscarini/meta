//
//  BMFWebViewLoadOperation.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 27/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFWebViewLoadOperation.h"

#import "BMF.h"


@interface BMFWebViewLoadOperation() <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) NSInteger numLoads;

@end

@implementation BMFWebViewLoadResult
@end


@implementation BMFWebViewLoadOperation

@synthesize progress = _progress;

- (instancetype) init {
    self = [super init];
    if (self) {
		_progress = [[BMFProgress alloc] init];
    }
    return self;
}

- (void) performCancel {
	
}

- (void)performStart {
	NSURL *url = nil;
	
	for (NSOperation *op in self.dependencies) {
		if ([op isKindOfClass:[BMFOperation class]]) {
			BMFOperation *previous = (BMFOperation *)op;
			if ([previous.output isKindOfClass:[NSURL class]]) {
				url = previous.output;
			}
			else {
				DDLogWarn(@"Previous operation is not a BMFOperation: %@",op);
			}
		}
	}

	dispatch_async(dispatch_get_main_queue(), ^{
		
		self.numLoads = 0;
		
		self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
		self.webView.delegate = self;

		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
		[self.webView loadRequest:request];
	});
}

#pragma mark UIWebViewDelegate

- (void) webViewDidStartLoad:(UIWebView *)webView {
	DDLogInfo(@"web view did start");
	[self.progress start];
	self.numLoads++;
	self.progress.totalUnitCount++;
	DDLogInfo(@"start numloads: %ld",(long)self.numLoads);
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	DDLogInfo(@"should start numloads: %ld",(long)self.numLoads);
	return YES;
}


- (void) webViewDidFinishLoad:(UIWebView *)webView {
	self.progress.completedUnitCount++;
	self.numLoads--;
	DDLogInfo(@"did finish numloads: %ld",(long)self.numLoads);
	if (self.numLoads==0) {
		[self.progress stop:nil];
		BMFWebViewLoadResult *result = [BMFWebViewLoadResult new];
		result.url = self.webView.request.mainDocumentURL;
		result.htmlString = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
		self.output = result;
		[self finished];
	}
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	self.progress.completedUnitCount++;
	self.numLoads--;
	DDLogInfo(@"did fail numloads: %ld",(long)self.numLoads);
	if (self.numLoads==0) {
		[self.progress stop:error];
		
		BMFWebViewLoadResult *result = [BMFWebViewLoadResult new];
		result.error = error;
		self.output = result;
		[self finished];
	}
}

- (void) dealloc {
	self.webView.delegate = nil;
	self.webView = nil;
}

@end
