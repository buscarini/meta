//
//  BMFDeviceOrientationCondition.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFCondition.h"

#import "BMFTypes.h"

@interface BMFDeviceOrientationCondition : BMFCondition

@property (nonatomic, assign) BMFDeviceOrientationAxis axis;

- (instancetype) initWithOrientationAxis:(BMFDeviceOrientationAxis) axis;

@end
