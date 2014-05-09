//
//  BMFTimerViewControllerBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 20/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFTimerViewControllerBehavior.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BMFTimerViewControllerBehavior ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BMFTimerViewControllerBehavior {
	RACDisposable *becomeActiveSubscription;
	RACDisposable *resignActiveSubscription;
}

- (void) viewWillAppear:(BOOL)animated {
	[self startTimer];
	
	becomeActiveSubscription = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil] subscribeNext:^(id x) {
		[self startTimer];
	}];

	resignActiveSubscription = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationWillResignActiveNotification object:nil] subscribeNext:^(id x) {
		[self stopTimer];
	}];
}

- (void) viewWillDisappear:(BOOL)animated {
	[becomeActiveSubscription dispose], becomeActiveSubscription = nil;
	[resignActiveSubscription dispose], resignActiveSubscription = nil;
	[self stopTimer];
}

- (void) dealloc {
	[becomeActiveSubscription dispose], becomeActiveSubscription = nil;
	[resignActiveSubscription dispose], resignActiveSubscription = nil;
	[self stopTimer];
}

- (void) startTimer {
	if (self.timer) [self stopTimer];
	self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

- (void) stopTimer {
	[self.timer invalidate], self.timer = nil;
}

- (void) update:(id) sender {
	if (self.actionBlock) self.actionBlock(self.object);
}

@end
