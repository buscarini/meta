//
//  BMFTaskManager.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 12/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFTaskManager.h"

#import "BMFWeakObject.h"
#import "BMF.h"

@interface BMFTaskManager()

@property (nonatomic, strong) NSMutableArray *tasks;

@end


@implementation BMFTaskManager

- (id)init
{
    self = [super init];
    if (self) {
        self.tasks = [NSMutableArray array];
    }
    return self;
}

- (void) dealloc {
	[self cancelAll];
}

- (void) addTask:(id<BMFTaskProtocol>) task {
	
	BMFAssertReturn(task);
	
//	if (!task) {
//		[NSException raise:@"Can't add a nil task" format:@"task can't be nil"];
//	}
	
	[self.tasks addObject:[[BMFWeakObject alloc] initWithObject:task]];
}

- (NSInteger) count {
	NSInteger numOps = 0;
	for (BMFWeakObject *weak in self.tasks) {
		if (weak.object) {
			numOps++;
		}
	}
	
	return numOps;
}

- (BOOL) allFinished {
	return (self.count>0);
}

- (void) cancelAll {
	for (BMFWeakObject *weak in self.tasks) {
		if (weak.object) {
			id<BMFTaskProtocol> task = (id<BMFTaskProtocol>)weak.object;
			[task cancel];
		}
	}
}

@end
