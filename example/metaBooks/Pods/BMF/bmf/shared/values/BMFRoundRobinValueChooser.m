//
//  BMFRoundRobinValueChooser.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFRoundRobinValueChooser.h"

@implementation BMFRoundRobinValueChooser

- (instancetype)init
{
    self = [super init];
    if (self) {
        _index = 0;
    }
    return self;
}

- (void) nextValue {
	_index++;
}

- (void) arrayAction:(NSArray *) input completion:(BMFCompletionBlock) completion {
	[self checkIndex:input.count];
	completion(input[_index],nil);
}

- (void) dicAction:(NSDictionary *) input completion:(BMFCompletionBlock) completion {
	[self checkIndex:input.allValues.count];
	completion(input.allValues[_index],nil);
}

- (void) checkIndex:(NSInteger)maxValues {
	if (_index>=maxValues) {
		_index = 0;
	}
}

@end
