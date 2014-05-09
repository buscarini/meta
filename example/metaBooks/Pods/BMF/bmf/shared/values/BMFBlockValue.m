//
//  BMFBlockValue.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFBlockValue.h"

#import "BMFTypes.h"

@implementation BMFBlockValue

- (instancetype) initWithBlock:(BMFBlockValueBlock) valueBlock {
	BMFAssertReturnNil(valueBlock);
	
    self = [super init];
    if (self) {
        _valueBlock = valueBlock;
    }
    return self;
}

- (instancetype)init {
	BMFInvalidInit(initWithBlock:);
}

- (void) setValueBlock:(BMFBlockValueBlock)valueBlock {
	BMFAssertReturn(valueBlock);
	
	_valueBlock = [valueBlock copy];
	
	if (self.applyValueBlock) self.applyValueBlock(self);
}

- (id) currentValue {
	id result = self.valueBlock();
	return [self prepareValue:result];
}

@end
