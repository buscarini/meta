//
//  BMFValue.m
//  ExampleMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import "BMFValue.h"

@implementation BMFValue

- (void) setApplyValueBlock:(BMFActionBlock)applyValueBlock {
	_applyValueBlock = applyValueBlock;
	
	if (applyValueBlock) applyValueBlock(self);
}

- (id) prepareValue:(id) value {
	if (![value BMF_isNotNull]) return nil;
	BMFValue *boxedValue = [BMFValue BMF_cast:value];
	if (boxedValue) {
		return [boxedValue currentValue];
	}
	
	return value;
}

- (id) currentValue {
	return nil;
}

@end
