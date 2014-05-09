//
//  BMFConditionalOperation.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFConditionalOperation.h"

#import "BMFTypes.h"

@implementation BMFConditionalOperation

- (instancetype) initWithCondition:(BMFParameterCondition *)condition {
	
	BMFAssertReturnNil(condition);
	
    self = [super init];
    if (self) {
        self.condition = condition;
    }
    return self;
}

- (id)init {
	BMFInvalidInit(initWithCondition:);
    return nil;
}


- (void)main {
	self.progress.completedUnitCount = 0;

	for (NSOperation *op in self.dependencies) {
		if ([op isKindOfClass:[BMFOperation class]]) {
			BMFOperation *previous = (BMFOperation *)op;
			
			if (previous.output) {
				
				self.condition.parameter = previous.output;
				if ([self.condition evaluate]) {
					self.output = previous.output;
				}
				else {
					if (self.unsatisfiedConditionBlock) self.unsatisfiedConditionBlock(previous.output);
				}
			}
		}
	}
	
	self.progress.completedUnitCount = 1;
}

@end
