//
//  BMFPropertyCondition.m
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 23/04/14.
//
//

#import "BMFPropertyCondition.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACExtScope.h>

#import "BMF.h"

@implementation BMFPropertyCondition

- (instancetype) initWithObject:(id) object keyPath:(NSString *) keyPath value:(id)value {
	BMFAssertReturnNil(object);
	BMFAssertReturnNil(keyPath);
	
    self = [super init];
    if (self) {
		_object = object;
		_keyPath = keyPath;
		_value = value;
		
		@weakify(self);
		[[object rac_valuesForKeyPath:_keyPath observer:self] subscribeNext:^(id value){
			@strongify(self);
			if (self.inputsChangedBlock) self.inputsChangedBlock(self);
		}];
    }
    return self;
}
	

- (instancetype) init {
	BMFInvalidInit(initWithObject:keyPath:);
}

- (BOOL) evaluate {
	return [[self.object valueForKeyPath:self.keyPath] isEqual:self.value];
}

@end
