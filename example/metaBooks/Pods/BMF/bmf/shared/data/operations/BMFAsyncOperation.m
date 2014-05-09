//
//  BMFAsyncOperation.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFAsyncOperation.h"

@implementation BMFAsyncOperation {
	BOOL _isExecuting;
	BOOL _isFinished;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.progress = [BMFProgress new];
    }
    return self;
}

- (void) start {
	[self willChangeValueForKey:@"isExecuting"];
	[self willChangeValueForKey:@"isFinished"];
	_isExecuting = YES;
	_isFinished = NO;
	[self didChangeValueForKey:@"isFinished"];
	[self didChangeValueForKey:@"isExecuting"];
	
	[self.progress start];
	
	[self performStart];
}

- (void) cancel {
	[self performCancel];
	
	[self.progress stop:nil];
	
	[self finished];
	
	[self willChangeValueForKey:@"isCancelled"];
	_cancelled = YES;
	[self didChangeValueForKey:@"isCancelled"];

}

- (void)finished {
	[self willChangeValueForKey:@"isExecuting"];
	[self willChangeValueForKey:@"isFinished"];
	_isExecuting = NO;
	_isFinished = YES;
	[self didChangeValueForKey:@"isFinished"];
	[self didChangeValueForKey:@"isExecuting"];
	
	[self.progress stop:nil];
}

- (BOOL) isCancelled {
	return _cancelled;
}

- (BOOL) isExecuting {
	return _isExecuting;
}

- (BOOL) isConcurrent {
	return YES;
}

- (BOOL) isFinished {
	return _isFinished;
}

- (void) performStart {}
- (void) performCancel {}

@end
