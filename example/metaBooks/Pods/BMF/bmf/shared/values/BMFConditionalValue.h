//
//  BMFConditionalValue.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFValue.h"
#import "BMFCondition.h"
#import "BMFPriorityCondition.h"

typedef NS_ENUM(NSUInteger, BMFConditionalValueMode) {
	BMFConditionalValueAllRequiredMode, /// Requires all conditions to be satisfied to use the value
	BMFConditionalValueBestMatchMode /// Chooses the value that matches more conditions, at least one
};


@interface BMFConditionalValue : BMFValue

/// BMFConditionalValueAllRequiredMode by default
@property (nonatomic, assign) BMFConditionalValueMode mode;

@property (nonatomic, strong) id defaultValue;

- (instancetype) initWithDefaultValue:(id) defaultValue;


/// Conditions should be an array of BMFCondition. The same priority (1) will be applied to each condition
- (void) addValue:(id) value conditions:(NSArray *) conditions;

/// Conditions should be an array of BMFCondition. The same priority will be applied to each condition
- (void) addValue:(id) value conditions:(NSArray *) conditions priority:(NSUInteger) priority;

/// Conditions should be an array of BMFPriorityCondition
- (void) addValue:(id) value priorityConditions:(NSArray *) conditions;


@end
