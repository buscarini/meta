//
//  BMFConditionalOperation.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFOperation.h"

#import "BMFParameterCondition.h"

@interface BMFConditionalOperation : BMFOperation

@property (nonatomic, strong) BMFParameterCondition *condition;
@property (nonatomic, strong) BMFActionBlock unsatisfiedConditionBlock;

- (instancetype) initWithCondition:(BMFParameterCondition *) condition;

@end
