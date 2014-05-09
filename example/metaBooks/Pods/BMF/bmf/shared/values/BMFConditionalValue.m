//
//  BMFConditionalValue.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFConditionalValue.h"

#import "BMFTypes.h"

#import "BMFCondition.h"

@interface BMFConditionalValue ()

@property (nonatomic, strong) NSMapTable *valueConditionsTable;

@end

@implementation BMFConditionalValue

- (instancetype) initWithDefaultValue:(id) defaultValue {
	self = [super init];
    if (self) {
		_defaultValue = defaultValue;
		_valueConditionsTable = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:5];
    }
    return self;
}

- (instancetype) init {
	return [self initWithDefaultValue:nil];
}

- (void) setApplyValueBlock:(BMFActionBlock)valueChangedBlock {
	[super setApplyValueBlock:valueChangedBlock];
	
	for (id value in self.valueConditionsTable.keyEnumerator) {
		NSArray *conditions = [self.valueConditionsTable objectForKey:value];
		for (BMFPriorityCondition *priorityCondition in conditions) {
			id<BMFCondition> condition = priorityCondition.condition;
			condition.inputsChangedBlock = ^(id<BMFCondition> condition) {
				if (self.applyValueBlock) self.applyValueBlock(self);
			};
		}
	}
}

- (void) addValue:(id) value conditions:(NSArray *) conditions {
	[self addValue:value conditions:conditions priority:1];
}

- (void) addValue:(id) value conditions:(NSArray *) conditions priority:(NSUInteger) priority {
	
	NSMutableArray *priorityConditions = [NSMutableArray array];
	for (id<BMFCondition> condition in conditions) {
		BMFPriorityCondition *priorityCondition = [[BMFPriorityCondition alloc] initWithCondition:condition priority:priority];
		[priorityConditions addObject:priorityCondition];
	}
	
	[self addValue:value priorityConditions:priorityConditions];
	
}

- (void) addValue:(id) value priorityConditions:(NSArray *) conditions {
	[self.valueConditionsTable setObject:conditions forKey:value];
}

- (id) currentValue {
	NSUInteger maxPriority = 0;
	id resultValue = nil;

	for (id value in self.valueConditionsTable.keyEnumerator) {
		NSUInteger priority = 0;
		BOOL allSatisfied = YES;
		BOOL oneSatisfied = NO;
		NSArray *conditions = [self.valueConditionsTable objectForKey:value];
		for (BMFPriorityCondition *condition in conditions) {
			if ([condition.condition evaluate]) {
				priority += condition.priority;
				oneSatisfied = YES;
			}
			else {
				allSatisfied = NO;
			}
		}
		
		if (self.mode==BMFConditionalValueAllRequiredMode && !allSatisfied) continue;
		if (self.mode==BMFConditionalValueBestMatchMode && !oneSatisfied) continue;
		
		if (priority>maxPriority) {
			maxPriority = priority;
			resultValue = value;
		}
	}
	
	if (maxPriority==0) resultValue = self.defaultValue;
	
	return [self prepareValue:resultValue];
}

@end
