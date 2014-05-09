//
//  BMFBlockOperation.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFBlockOperation.h"

@implementation BMFBlockOperation

- (instancetype) initWithBlock: (BMFOperationBlock) block {
    self = [super init];
    if (self) {
        self.block = block;
		self.progress = [[BMFProgress alloc] init];
    }
    return self;
}

- (id)init {
	DDLogError(@"Block operation needs a block to work. Use initWithBlock instead");
    return nil;
}


- (void)performStart {
	self.block(self,^(id result, NSError *error) {
		self.output = result;
		self.progress.failedError = error;
		if (!self.cancelled) [self finished];
	});
}


@end
