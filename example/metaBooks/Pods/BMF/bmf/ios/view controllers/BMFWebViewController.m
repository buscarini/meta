//
//  BMFWebViewController.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFWebViewController.h"

@interface BMFWebViewController () <UIWebViewDelegate>

@end

@implementation BMFWebViewController

//@synthesize loaderView = _loaderView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.webView.delegate = self;
	self.contentSizeMargin = CGSizeMake(20, 20);
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self reload];
}

- (void) setDetailItem:(id)detailItem {
	_detailItem = detailItem;
	
	if (self.isVisible) [self reload];
}

- (void) reload {
	if (!self.detailItem) return;

	[self.loaderView.progress start];
	
	NSString *htmlContent = [NSString BMF_cast:self.detailItem];
	if (htmlContent) {
		[self.webView loadHTMLString:htmlContent baseURL:nil];
	}
	else {
		NSURL *url = [NSURL BMF_cast:self.detailItem];
		if (url) {
			[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
		}
	}
}

#pragma mark UIWebViewDelegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if (self.webDelegate) {
		if ([self.webDelegate openUrlExternally:request.URL navigationType:navigationType]) {
			[[UIApplication sharedApplication] openURL:request.URL];
			return NO;
		}
	}
	
	return YES;
}

- (void) webViewDidStartLoad:(UIWebView *)webView {
	self.preferredContentSize = CGSizeMake(320, 10);

	[self.loaderView.progress start];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
	self.preferredContentSize = CGSizeMake(webView.scrollView.contentSize.width+self.contentSizeMargin.width,webView.scrollView.contentSize.height+self.contentSizeMargin.height);

	[self.loaderView.progress stop:nil];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	self.preferredContentSize = CGSizeMake(webView.scrollView.contentSize.width+self.contentSizeMargin.width,webView.scrollView.contentSize.height+self.contentSizeMargin.height);
	
	DDLogError(@"Error loading web view: %@",error);
	[self.loaderView.progress stop:error];
}


@end
