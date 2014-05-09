//
//  BMFCondition.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@protocol BMFCondition

/// Passes self to the block when the evaluation result might change
@property (nonatomic, strong) BMFActionBlock inputsChangedBlock;

- (BOOL) evaluate;

@end

typedef NS_ENUM(NSUInteger, BMFConditionComparisonType) {
	BMFConditionLessThanComparisonType,
	BMFConditionLessThanOrEqualComparisonType,
	BMFConditionEqualComparisonType,
	BMFConditionDifferentComparisonType,
	BMFConditionGreaterThanComparisonType,
	BMFConditionGreaterThanOrEqualComparisonType
};

@interface BMFCondition : NSObject <BMFCondition>

@property (nonatomic, strong) BMFActionBlock inputsChangedBlock;

- (BOOL) evaluate;

+ (BMFCondition *) not:(BMFCondition *) condition;

@end

@interface BMFTrueCondition : BMFCondition
@end

@interface BMFFalseCondition : BMFCondition
@end
