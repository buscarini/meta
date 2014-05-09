//
//  BMFPriorityCondition.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFPriorityCondition.h"

#import "BMFTypes.h"

@implementation BMFPriorityCondition

- (instancetype) initWithCondition:(id<BMFCondition>) condition priority:(NSUInteger) priority {
	BMFAssertReturnNil(condition);
	BMFAssertReturnNil(priority>0);
	
	self = [super init];
    if (self) {
		_condition = condition;
		_priority = priority;
    }
    return self;
}

- (instancetype) init {
	[NSException raise:@"BMFConditionalValue needs a default value. Use initWithValue: instead" format:@""];
	return nil;
}

@end
