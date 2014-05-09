//
//  BMFConfiguration.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFConfiguration.h"

#import "BMFTypes.h"

@interface BMFConfiguration ()

@property (nonatomic, strong) NSMutableArray *storedModules;

@end

@implementation BMFConfiguration

- (NSArray *)modules {
	return [NSArray arrayWithArray:_storedModules];
}

- (instancetype) init {
	self = [super init];
	if (self) {
		_storedModules = [NSMutableArray array];
	}
	return self;
}

- (void) addModule:(id<BMFConfigurationProtocol>)module {
	BMFAssertReturn(module);
	[_storedModules addObject:module];
}

- (BOOL) setup {
	
	BOOL result = YES;
	for (id<BMFConfigurationProtocol> module in self.modules) {
		result &= [module setup];
	}
	
	return result;
}

- (void) tearDown {
	for (id<BMFConfigurationProtocol> module in self.modules) {
		[module tearDown];
	}
}

@end
