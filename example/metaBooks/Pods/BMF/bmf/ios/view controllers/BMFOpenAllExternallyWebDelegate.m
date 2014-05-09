//
//  BMFOpenAllExternallyWebDelegate.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFOpenAllExternallyWebDelegate.h"

@implementation BMFOpenAllExternallyWebDelegate

- (BOOL) openUrlExternally:(NSURL *) url navigationType:(UIWebViewNavigationType) navigationType {

	/*if ([url.scheme isEqualToString:@"mailto"]) {
		[[UIApplication sharedApplication] openURL:url];
		return NO;
	}*/
	
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        return YES;
    }
	
    return NO;
}

@end
