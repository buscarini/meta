//
//  BMFOperationsManager.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFOperationsManager.h"

#import "BMFWeakObject.h"
#import "BMF.h"

@interface BMFOperationsManager()

@property (nonatomic, strong) NSMutableArray *operations;

@end

@implementation BMFOperationsManager

- (id)init
{
    self = [super init];
    if (self) {
        self.operations = [NSMutableArray array];
    }
    return self;
}

- (void) dealloc {
	[self cancelAll];
}

- (void) addOperation: (NSOperation *) operation {
	if (!operation) {
		[NSException raise:@"Can't add a nil operation" format:@"operation can't be nil"];
	}
	
	[self.operations addObject:[[BMFWeakObject alloc] initWithObject:operation]];
}

- (NSInteger) count {
	NSInteger numOps = 0;
	for (BMFWeakObject *weak in self.operations) {
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
	for (BMFWeakObject *weak in self.operations) {
		if (weak.object) {
			NSOperation *op = [NSOperation BMF_cast:weak.object];
			[op cancel];
		}
	}
}

@end
