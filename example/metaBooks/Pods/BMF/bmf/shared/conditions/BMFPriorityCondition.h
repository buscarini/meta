//
//  BMFPriorityCondition.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFCondition.h"

@interface BMFPriorityCondition : NSObject

@property (nonatomic, strong) id<BMFCondition> condition;
@property (nonatomic, assign) NSUInteger priority;
- (instancetype) initWithCondition:(id<BMFCondition>) condition priority:(NSUInteger) priority;

@end