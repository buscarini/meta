//
//  TNProgress.m
//  DataSources
//
//  Created by José Manuel Sánchez on 12/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFProgress.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#import "BMF.h"

#import "BMFMutableWeakArray.h"

@interface BMFProgress()

//@property (nonatomic, strong) NSMutableSet *children;
@property (nonatomic, strong) BMFMutableWeakArray *children;

@end

@implementation BMFProgress {
	dispatch_queue_t serialQueue;

	RACReplaySubject *_childrenEstimatedTimeSignal;
	RACReplaySubject *_childrenFractionCompletedSignal;
	RACReplaySubject *_childrenRunningSignal;
	RACReplaySubject *_childrenMessageSignal;
}

@synthesize running = _running;
@synthesize totalUnitCount = _totalUnitCount;
@synthesize completedUnitCount = _completedUnitCount;
@synthesize failedError = _failedError;

- (id)init
{
    self = [super init];
    if (self) {
		
		serialQueue = dispatch_queue_create("BMFProgress queue", DISPATCH_QUEUE_CONCURRENT);
		
		self.totalUnitCount = 1;
		self.estimatedTime = 1; // 1 second by default

		dispatch_sync(serialQueue, ^{
			self.children = [BMFMutableWeakArray new];
			
			
			_childrenEstimatedTimeSignal = [RACReplaySubject subject];
			_childrenFractionCompletedSignal = [RACReplaySubject subject];
			_childrenRunningSignal = [RACReplaySubject subject];
			_childrenMessageSignal = [RACReplaySubject subject];
			
			@weakify(self);
			[[_childrenEstimatedTimeSignal flatten] subscribeNext:^(id x) {
				@strongify(self);
				int64_t total = 0;
				
				__block NSArray *children = nil;
				dispatch_sync(serialQueue, ^{
					children = [self.children copy];
				});
				
				for (BMFProgress *child in children) {
					total += child.estimatedTime;
				}
				self.estimatedTime = total;
			}];
			
			[[_childrenFractionCompletedSignal flatten] subscribeNext:^(id x) {
				@strongify(self);
				int64_t total = 0;
				int64_t completed = 0;
				
				__block NSArray *children = nil;
				dispatch_sync(serialQueue, ^{
					children = [self.children copy];
				});
				
				for (BMFProgress *child in children) {
					total += child.totalUnitCount;
					completed += child.completedUnitCount;
				}
				
				self.totalUnitCount = total;
				self.completedUnitCount = completed;
				
			}];
			
			[[_childrenRunningSignal flatten] subscribeNext:^(id x) {
				@strongify(self);
				BOOL running = NO;
				
				__block NSArray *children = nil;
				dispatch_sync(serialQueue, ^{
					children = [self.children copy];
				});
				
				for (BMFProgress *child in children) {
					DDLogInfo(@"child: %@ %d",child,child.running);
					if (child.running) {
						running = YES;
						break;
					}
				}
				
				DDLogInfo(@"running: %d",running);
				
				self.running = running;
			}];
			
			[[_childrenMessageSignal flatten] subscribeNext:^(id x) {
				@strongify(self);
				
				__block NSArray *children = nil;
				dispatch_sync(serialQueue, ^{
					children = [self.children copy];
				});
				
				for (BMFProgress *child in children) {
					if (child.running && child.progressMessage.length>0) {
						self.progressMessage = child.progressMessage;
						break;
					}
				}
			}];
		});
    }
    return self;
}

- (int64_t) totalUnitCount {
	__block int64_t result = 0;
	
	dispatch_sync(serialQueue, ^{
		result = _totalUnitCount;
	});
	
	return result;
}

- (void) setTotalUnitCount:(int64_t)totalUnitCount {
	[self willChangeValueForKey:@"totalUnitCount"];
	dispatch_sync(serialQueue, ^{
		_totalUnitCount = totalUnitCount;
	});
	[self didChangeValueForKey:@"totalUnitCount"];
}

- (CGFloat) fractionCompleted {
	__block CGFloat result = 0;
	dispatch_sync(serialQueue, ^{
		if (_totalUnitCount==0) _totalUnitCount = 1;
		result = _completedUnitCount/_totalUnitCount;
	});
	
	return result;
}

- (void) clear {
	self.completedUnitCount = 0;
	self.progressMessage = nil;
	self.failedError = nil;
}

- (BOOL) running {
	__block BOOL result = NO;
	dispatch_sync(serialQueue, ^{
		result = _running;
	});
	return result;
}

- (void) setRunning:(BOOL)running {
	[self willChangeValueForKey:@"running"];
	dispatch_sync(serialQueue, ^{
		_running = running;
	});
	[self didChangeValueForKey:@"running"];
}

- (int64_t) completedUnitCount {
	__block int64_t result = 0;
	dispatch_sync(serialQueue, ^{
		result = _completedUnitCount;
	});
	
	return result;
}

- (void) setCompletedUnitCount:(int64_t)completedUnitCount {
	[self willChangeValueForKey:@"completedUnitCount"];
	[self willChangeValueForKey:@"fractionCompleted"];
	dispatch_sync(serialQueue, ^{
		_completedUnitCount = completedUnitCount;
	});
	[self didChangeValueForKey:@"fractionCompleted"];
	[self didChangeValueForKey:@"completedUnitCount"];
}

- (NSError *) failedError {
	__block NSError *result = nil;
	dispatch_sync(serialQueue, ^{
		result = _failedError;
	});
	
	return result;
}

- (void) setFailedError:(NSError *)failedError {
	[self willChangeValueForKey:@"failedError"];
	[self willChangeValueForKey:@"progressMessage"];
	dispatch_sync(serialQueue, ^{
		_failedError = failedError;
		_progressMessage = [failedError localizedDescription];
	});
	[self didChangeValueForKey:@"progressMessage"];
	[self didChangeValueForKey:@"failedError"];
}

- (void) addChild:(BMFProgress *) child {

	if (!child) {
		return;	
	}
	
	dispatch_sync(serialQueue, ^{
		[self.children addObject:child];
		
		[_childrenEstimatedTimeSignal sendNext:RACObserve(child, estimatedTime)];
		[_childrenFractionCompletedSignal sendNext:RACObserve(child, fractionCompleted)];
		[_childrenRunningSignal sendNext:RACObserve(child, running)];
		[_childrenMessageSignal sendNext:RACObserve(child, progressMessage)];
	});
}

- (void) update {
	if (_children.count==0) return;
	
	__block NSArray *children = nil;
	
	dispatch_sync(serialQueue, ^{
		children = [self.children copy];
	});
	
	int64_t updatedEstimatedTime = 0;
	int64_t updatedTotalUnitCount = 0;
	int64_t updatedCompletedUnitCount = 0;
	
	for (BMFProgress *child in children) {
		updatedEstimatedTime += child.estimatedTime;
		updatedTotalUnitCount += child.totalUnitCount;
		updatedCompletedUnitCount += child.completedUnitCount;
	}
	
	[self willChangeValueForKey:@"completedUnitCount"];
	[self willChangeValueForKey:@"fractionCompleted"];
	[self willChangeValueForKey:@"totalUnitCount"];
	[self willChangeValueForKey:@"estimatedTime"];
	
	dispatch_sync(serialQueue, ^{
		_estimatedTime = updatedEstimatedTime;
		_totalUnitCount = updatedTotalUnitCount;
		_completedUnitCount = updatedCompletedUnitCount;
	});
	
	[self didChangeValueForKey:@"estimatedTime"];
	[self didChangeValueForKey:@"totalUnitCount"];
	[self didChangeValueForKey:@"fractionCompleted"];
	[self didChangeValueForKey:@"completedUnitCount"];
}

- (void) start {
	BMFAssertReturn(self.children.count==0);
	
	[self clear];
	
	self.running = YES;
}

- (void) stop: (NSError *) error {
	self.running = NO;
	self.completedUnitCount = self.totalUnitCount;
	self.failedError = error;
}

- (void) dealloc {
	dispatch_sync(serialQueue, ^{
//		DDLogDebug(@"dealloc bmfprogress: %@",self);
		
		[_childrenEstimatedTimeSignal sendCompleted];
		[_childrenFractionCompletedSignal sendCompleted];
		[_childrenRunningSignal sendCompleted];
	});
	
	[self clear];
}

@end
