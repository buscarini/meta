//
//  BMFFixedValueChooser.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 15/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFFixedValueChooser.h"

@implementation BMFFixedValueChooser

- (instancetype)init
{
    self = [super init];
    if (self) {
        _index = 0;
    }
    return self;
}


- (void) arrayAction:(NSArray *) input completion:(BMFCompletionBlock) completion {
	completion(input[self.index],nil);
}

- (void) dicAction:(NSDictionary *) input completion:(BMFCompletionBlock) completion {
	if (self.key){
		completion(input[self.key],nil);
	}
	else {
		[super dicAction:input completion:completion];
	}
}

@end
