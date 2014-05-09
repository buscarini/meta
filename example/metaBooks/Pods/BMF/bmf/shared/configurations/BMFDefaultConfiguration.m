//
//  BMFDefaultConfiguration.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 23/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFDefaultConfiguration.h"

#import <DDTTYLogger.h>
#import <DDASLLogger.h>

#import "BMFUrlCacheConfigurationModule.h"
#import "BMFMagicalRecordConfigurationModule.h"

#if TARGET_OS_IPHONE
//#import "BMFCrashlyticsConfigurationModule.h"
//#import "BMFFlurryConfigurationModule.h"
#endif

#import "BMFTypes.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BMFDefaultConfiguration()

@property (nonatomic, strong) BMFUrlCacheConfigurationModule *cacheModule;

@end

@implementation BMFDefaultConfiguration

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.setupSharedCache = NO;
    }
    return self;
}

- (void) setCacheDiskSize:(int)cacheDiskSize {
	[self.cacheModule setCacheDiskSize:cacheDiskSize];
}

- (int) cacheDiskSize {
	return [self.cacheModule cacheDiskSize];
}

- (void) setCacheMemorySize:(int)cacheMemorySize {
	[self.cacheModule setCacheMemorySize:cacheMemorySize];
}

- (int) cacheMemorySize {
	return [self.cacheModule cacheMemorySize];
}

- (void) setUseCoreData:(BOOL)useCoreData {
	_useCoreData = useCoreData;
	if (_useCoreData) {
		BMFMagicalRecordConfigurationModule *mrModule = [BMFMagicalRecordConfigurationModule new];
		[self addModule:mrModule];
	}
}

- (BOOL) setup {
	[DDLog addLogger:[DDASLLogger sharedInstance]];
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	if (self.setupSharedCache) {
		self.cacheModule = [BMFUrlCacheConfigurationModule new];
		[self addModule:self.cacheModule];
	}
	
#if TARGET_OS_IPHONE
	if (_crashlyticsApiKey.length>0) {
		Class crashlyticsModule = NSClassFromString(@"BMFCrashlyticsConfigurationModule");
		SEL initSelector = NSSelectorFromString(@"initWithApiKey:");
		
		BMFSuppressPerformSelectorLeakWarning(
											  BMFConfiguration *module = [[crashlyticsModule alloc] performSelector:initSelector withObject:_crashlyticsApiKey];
											  [self addModule:module];
											  
											  );
		
		
		//			BMFCrashlyticsConfigurationModule *crashModule = [[BMFCrashlyticsConfigurationModule alloc] initWithApiKey:_crashlyticsApiKey];
		
	}
	
	if (_flurryApiKey.length>0) {
		Class flurryModule = NSClassFromString(@"BMFFlurryConfigurationModule");
		SEL initSelector = NSSelectorFromString(@"initWithApiKey:");
		
		BMFSuppressPerformSelectorLeakWarning(
											  BMFConfiguration *eventsModule = [[flurryModule alloc] performSelector:initSelector withObject:_flurryApiKey];
											  [self addModule:eventsModule];
											  );
	}
#endif
	
	[super setup];
	
	return YES;
}

- (void) tearDown {
	[super tearDown];
}

@end
