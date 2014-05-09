//
//  BMFBlockCondition.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFParameterCondition.h"

typedef BOOL(^BMFConditionBlock)(id parameter);

@interface BMFBlockCondition : BMFParameterCondition

@property (nonatomic, copy) BMFConditionBlock block;

- (instancetype) initWithBlock:(BMFConditionBlock)block;

@end
