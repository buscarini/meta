//
//  BMFBlockActivity.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFBlockActivity.h"

#import "BMFTypes.h"

@implementation BMFBlockActivity

- (instancetype) initWithBlock:(BMFBlockActivityBlock) block {
	BMFAssertReturnNil(block);
	
	self = [super init];
	if (self) {
		self.block = block;
	}
	
	return self;
}

- (void) run:(BMFCompletionBlock)completionBlock {
	self.block(self,self.value,completionBlock);
}

@end
