//
//  BMFDeviceOrientationCondition.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFDeviceOrientationCondition.h"

#import "BMFDevice.h"
#import "BMFTypes.h"

@interface BMFDeviceOrientationCondition()

@property (nonatomic, strong) id observer;

@end

@implementation BMFDeviceOrientationCondition

- (instancetype) initWithOrientationAxis:(BMFDeviceOrientationAxis)axis {
	self = [super init];
    if (self) {
		self.axis = axis;
    }
    return self;
}

- (instancetype) init {
	[NSException raise:@"BMFDeviceOrientationCondition needs an axis. Use initWithOrientationAxis: instead" format:@""];
	return nil;
}

- (void) setInputsChangedBlock:(BMFActionBlock)inputsChangedBlock {
	[super setInputsChangedBlock:inputsChangedBlock];

	if (!self.observer) {		
		[[NSNotificationCenter defaultCenter] addObserverForName:BMFApplicationDidChangeOrientationNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
			if (self.inputsChangedBlock) self.inputsChangedBlock(self);
		}];
	}
}

- (BOOL) evaluate {
	return (self.axis==[BMFDevice currentDeviceOrientationAxis]);
}

- (void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}

@end
