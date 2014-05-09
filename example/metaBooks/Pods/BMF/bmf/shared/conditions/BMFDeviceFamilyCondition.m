//
//  BMFDeviceFamilyCondition.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFDeviceFamilyCondition.h"

#import "BMFDevice.h"

@implementation BMFDeviceFamilyCondition

- (instancetype) initWithDeviceFamily:(BMFDeviceFamily) family {
	self = [super init];
    if (self) {
		self.family = family;
    }
    return self;
}

- (instancetype) init {
	[NSException raise:@"BMFDeviceFamilyCondition needs a family. Use initWithDeviceFamily: instead" format:@""];
	return nil;
}

- (BOOL) evaluate {
	return (self.family==[BMFDevice currentDeviceFamily]);
}

@end
