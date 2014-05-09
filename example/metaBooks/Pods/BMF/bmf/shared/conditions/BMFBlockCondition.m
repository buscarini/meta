//
//  BMFBlockCondition.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFBlockCondition.h"

#import "BMFTypes.h"

@implementation BMFBlockCondition

- (instancetype) initWithBlock:(BMFConditionBlock)block {
	BMFAssertReturnNil(block);
	
	self = [super init];
    if (self) {
		self.block = block;
    }
    return self;
}

- (instancetype) init {
	BMFInvalidInit(initWithBlock:);
}

- (BOOL) evaluate {
	
	BMFAssertReturnNO(self.block);
	
	return self.block(self.parameter);
}

@end
