//
//  BMFBlockValue.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFValue.h"

typedef id(^BMFBlockValueBlock)();

@interface BMFBlockValue : BMFValue

@property (nonatomic, copy) BMFBlockValueBlock valueBlock;

- (instancetype) initWithBlock:(BMFBlockValueBlock) valueBlock;

@end
