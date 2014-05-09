//
//  BMFDeviceValue.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 27/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"
#import "BMFConditionalValue.h"

@interface BMFDeviceValue : BMFConditionalValue

//@property (nonatomic, strong) id defaultValue;
//
//- (id) initWithDefaultValue:(id) value;

- (void) setValue:(id)value forFamily:(BMFDeviceFamily) family;
- (void) setValue:(id)value forFamily:(BMFDeviceFamily) family orientationAxis:(BMFDeviceOrientationAxis) orientation;
- (void) setValue:(id)value forFamily:(BMFDeviceFamily) family orientationAxis:(BMFDeviceOrientationAxis) orientation batteryState:(BMFDeviceBatteryState)batteryState;
- (void) setValue:(id)value forFamily:(BMFDeviceFamily) family orientationAxis:(BMFDeviceOrientationAxis) orientation batteryState:(BMFDeviceBatteryState)batteryState model:(NSString *)model;

//- (id) currentValue;

@end
