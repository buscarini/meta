//
//  BMFUrlCacheConfigurationModule.m
//  ExampleMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/04/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import "BMFUrlCacheConfigurationModule.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation BMFUrlCacheConfigurationModule

- (instancetype)init
{
    self = [super init];
    if (self) {
		_cacheMemorySize = 4*1024*1024;
		_cacheDiskSize = 20*1024*1024;
    }
    return self;
}

- (BOOL) setup {
	
	NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:self.cacheMemorySize diskCapacity:self.cacheDiskSize diskPath:@"bmf"];
	[NSURLCache setSharedURLCache:sharedCache];
		
#if TARGET_OS_IPHONE
	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil] subscribeNext:^(id x) {
		[[NSURLCache sharedURLCache] removeAllCachedResponses];
	}];
#endif

	return YES;
}

- (void) tearDown {
}

@end
