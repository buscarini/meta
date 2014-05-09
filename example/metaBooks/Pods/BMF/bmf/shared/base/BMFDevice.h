//
//  BMFDevice.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 27/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@interface BMFDevice : NSObject

+ (NSString *) currentDeviceModel;
+ (NSString *) currentSystemVersion;
+ (BOOL) systemVersionGreaterEqualTo:(NSString *) version;
+ (BMFDeviceFamily) currentDeviceFamily;
+ (BMFDeviceOrientation) currentDeviceOrientation;
+ (BMFDeviceOrientationAxis) currentDeviceOrientationAxis;
+ (BMFDeviceBatteryState) currentDeviceBatteryState;


@end
