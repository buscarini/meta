//
//  BMFFixedValue.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 17/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFFixedValue.h"

#import "BMFTypes.h"

@implementation BMFFixedValue

- (instancetype) initWithValue:(id) value {
	self = [super init];
	if (self) {
		_value = value;
	}
	return self;
}

- (instancetype) init {
	return [self initWithValue:nil];
}

- (void) setValue:(id)value {
	_value = value;
	
	if (self.applyValueBlock) self.applyValueBlock(self);
}

- (id) currentValue {
	return [self prepareValue:self.value];
}

@end
