//
//  BMFSystemVersionCondition.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFCondition.h"

@interface BMFSystemVersionCondition : BMFCondition

@property (nonatomic, copy) NSString *systemVersion;
@property (nonatomic, assign) BMFConditionComparisonType comparisonType;

- (instancetype) initWithSystemVersion:(NSString *) systemVersion comparisonType:(BMFConditionComparisonType) comparisonType;


@end
