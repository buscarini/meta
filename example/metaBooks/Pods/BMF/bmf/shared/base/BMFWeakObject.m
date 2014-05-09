//
//  BMFWeakObject.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFWeakObject.h"

#import "BMFTypes.h"

@implementation BMFWeakObject

- (instancetype) initWithObject:(id) object {
	BMFAssertReturnNil(object);
	
    self = [super init];
    if (self) {
        self.object = object;
    }
    return self;
}

- (instancetype) init {
	[NSException raise:@"No object specified" format:@"Use initWithObject instead"];
    return nil;
}

- (BOOL) isEqual:(id)object {
	return [_object isEqual:object];
}

@end
