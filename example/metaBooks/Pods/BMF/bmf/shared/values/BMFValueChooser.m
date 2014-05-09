//
//  BMFValueChooser.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFValueChooser.h"

#import "BMF.h"

@implementation BMFValueChooser

- (void) nextValue {
	if (self.value && self.value.applyValueBlock) self.value.applyValueBlock(self.value);
}

- (void) action:(id) input completion:(BMFCompletionBlock) completion {
	BMFAssertReturn(completion);
	
	NSArray *array = [NSArray BMF_cast:input];
	NSDictionary *dic = [NSDictionary BMF_cast:input];
	if (array) {
		[self arrayAction:array completion:completion];
	}
	else if (dic) {
		[self dicAction:dic completion:completion];
	}
	else {
		[self valueAction:input completion:completion];
	}
}


- (void) valueAction:(id) input completion:(BMFCompletionBlock) completion {
	completion(input,nil);
}

- (void) arrayAction:(NSArray *) input completion:(BMFCompletionBlock) completion {
	completion(input[0],nil);
}

- (void) dicAction:(NSDictionary *) input completion:(BMFCompletionBlock) completion {
	[self arrayAction:input.allValues[0] completion:completion];
}


@end
