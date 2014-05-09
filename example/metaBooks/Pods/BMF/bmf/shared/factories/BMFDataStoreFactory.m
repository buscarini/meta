//
//  BMFDataStoreFactory.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 31/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFDataStoreFactory.h"

static NSMutableArray *factories = nil;

@implementation BMFDataStoreFactory

+ (void) load {
	factories = [NSMutableArray array];
}

+ (void) register {
	[factories addObject:[self new]];
}

+ (void) unregister {
	id instance = nil;
	for (id factory in factories) {
		if ([factory class]==self) {
			instance = factory;
			break;
		}
	}
	
	if (instance) [factories removeObject:instance];
}

+ (NSArray *) availableFactories {
	return factories;
}

@end
