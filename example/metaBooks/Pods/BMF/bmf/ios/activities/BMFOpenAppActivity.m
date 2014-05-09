//
//  BMFOpenAppActivity.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFOpenAppActivity.h"

#import "BMF.h"

@implementation BMFOpenAppActivity

- (instancetype) initWithUrl:(NSURL *) urlScheme {
	BMFAssertReturnNil(urlScheme);
	
	self = [super init];
	if (self) {
		self.urlScheme = urlScheme;
	}
	return self;
}

- (id)init {
	[NSException raise:@"urlScheme is needed. Use initWithUrl: instead" format:nil];
	return nil;
}

- (void) run:(BMFCompletionBlock)completionBlock {

	if ([[UIApplication sharedApplication] canOpenURL:self.urlScheme]) {
		BOOL result = [[UIApplication sharedApplication] openURL:self.urlScheme];
		NSError *error = nil;
		if (!result) error = [NSError errorWithDomain:@"Activity" code:BMFErrorData userInfo:@{ NSLocalizedDescriptionKey : BMFLocalized(@"Error opening url scheme", nil) }];
		if (completionBlock) completionBlock(self.urlScheme,error);
	}
	else if (self.urlAppStore) {
		BOOL result = [[UIApplication sharedApplication] openURL:self.urlAppStore];
		NSError *error = nil;
		if (!result) error = [NSError errorWithDomain:@"Activity" code:BMFErrorData userInfo:@{ NSLocalizedDescriptionKey : BMFLocalized(@"Error opening app store url", nil) }];
		if (completionBlock) completionBlock(self.urlAppStore,error);
	}
	else {
		if (completionBlock) completionBlock(nil,[NSError errorWithDomain:@"Activity" code:BMFErrorData userInfo:@{ NSLocalizedDescriptionKey : BMFLocalized(@"App for url scheme is not installed, and no app store link provided",nil) }]);
	}
	
}

@end
