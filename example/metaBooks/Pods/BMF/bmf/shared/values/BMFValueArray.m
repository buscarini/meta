//
//  BMFValueArray.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFValueArray.h"

#import "BMF.h"
#import "BMFRoundRobinValueChooser.h"

@interface BMFValueArray()

@property (nonatomic, assign) NSInteger index;

@end

@implementation BMFValueArray

- (instancetype) initWithValues:(NSArray *) values {
	BMFAssertReturnNil(values.count>0);
	
    self = [super init];
    if (self) {
        _index = 0;
		_values = values;
		_valueChooser = [BMFRoundRobinValueChooser new];
    }
    return self;
}

- (void) setValues:(NSArray *)values {
	BMFAssertReturn(values.count>0);
	_values = values;
}

- (instancetype)init {
	BMFInvalidInit(initWithValues:);
}

- (id) currentValue {
	__block id currentValue = nil;
	[_valueChooser action:self.values completion:^(id result, NSError *error) {
		currentValue = [self prepareValue:result];
	}];

	return currentValue;
}

@end
