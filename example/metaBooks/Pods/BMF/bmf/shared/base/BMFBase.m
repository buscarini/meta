//
//  BMFBase.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFBase.h"

#if TARGET_OS_IPHONE
#import "BMFIOSDefaultFactory.h"
#import "BMFKeyboardManager.h"
#else
#import "BMFDefaultFactory.h"
#endif


#import <DDTTYLogger.h>
#import <DDASLLogger.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

static BMFBase *instance = nil;

@interface BMFBase()

@property (nonatomic, strong) id<BMFConfigurationProtocol> config;

@end

@implementation BMFBase

+ (BMFBase *) sharedInstance {
	if (!instance) {
		instance = [[BMFBase alloc] init];
	}
	
	return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
		self.backgroundQueue = [NSOperationQueue new];
        self.backgroundQueue.name = @"BMF Background Operations Queue";
		self.backgroundQueue.maxConcurrentOperationCount = 4;

		self.networkQueue = [NSOperationQueue new];
        self.networkQueue.name = @"BMF Network Operations Queue";
		self.networkQueue.maxConcurrentOperationCount = 3;

		self.highPriorityQueue = [NSOperationQueue new];
        self.highPriorityQueue.name = @"BMF High Priority Operations Queue";
		
#if TARGET_OS_IPHONE
		
		self.factory = [BMFIOSDefaultFactory new];
		
		self.keyboardManager = [BMFKeyboardManager new];
#else

		self.factory = [BMFDefaultFactory new];
#endif
		
		NSURL *bundleUrl = [[NSBundle mainBundle] URLForResource:@"BMF" withExtension:@"bundle"];
		if (bundleUrl) self.bundle = [NSBundle bundleWithURL:bundleUrl];
		else self.bundle = [NSBundle mainBundle];
		
		#if TARGET_OS_IPHONE
		[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil] subscribeNext:^(id x) {
			self.storyboard = [[[[UIApplication sharedApplication] keyWindow] rootViewController] storyboard];
		}];
	#endif
		
		[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFApplicationWillTerminateNotification object:nil] subscribeNext:^(id x) {
			[self willTerminate:x];
		}];

    }
    return self;
}

- (void) loadConfig:(id<BMFConfigurationProtocol>) config {
	
	self.config = config;
	
	[self.config setup];
}

#pragma mark App Events

- (void) willTerminate:(NSNotification *) notification {
	[self.config tearDown];
}

- (BMFIXImage *) imageNamed:(NSString *) imageName {
	NSString *extension = [imageName pathExtension];
	if (extension.length>0) imageName = [imageName stringByDeletingPathExtension];
	else extension = @"png";
	
	NSString *path = [self.bundle pathForResource:imageName ofType:extension];
	if (!path) return nil;
	return [BMFImage imageWithContentsOfFile:path];
}



@end
