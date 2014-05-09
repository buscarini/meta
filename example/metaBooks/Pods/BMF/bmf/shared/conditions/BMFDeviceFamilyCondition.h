//
//  BMFDeviceFamilyCondition.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFCondition.h"

#import "BMFTypes.h"

@interface BMFDeviceFamilyCondition : BMFCondition

@property (nonatomic, assign) BMFDeviceFamily family;

- (instancetype) initWithDeviceFamily:(BMFDeviceFamily) family;

@end
