//
//  BMFTimerEvent.m
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/04/14.
//
//

#import "BMFTimerEvent.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@implementation BMFTimerEvent

- (instancetype) initWithInterval:(NSTimeInterval) interval {
	BMFAssertReturnNil(interval>0);
	self = [super init];
	if (self) {
		_interval = interval;
		@weakify(self);
		[[RACSignal interval:interval onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
			@strongify(self);
			self.eventBlock(self);
		}];
	}
	return self;
}

@end
