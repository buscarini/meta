//
//  BMFDevice.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 27/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFDevice.h"

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/sysctl.h>

#if !TARGET_OS_IPHONE
#import <IOKit/ps/IOPowerSources.h>
#import <IOKit/ps/IOPSKeys.h>
#endif

@implementation BMFDevice


+ (NSString *) currentDeviceModel {
#if TARGET_OS_IPHONE
	return [[UIDevice currentDevice] model];
#else
	size_t len = 0;
    sysctlbyname("hw.model", NULL, &len, NULL, 0);
	
    if (len)
    {
        char *model = malloc(len*sizeof(char));
        sysctlbyname("hw.model", model, &len, NULL, 0);
        NSString *model_ns = [NSString stringWithUTF8String:model];
        free(model);
        return model_ns;
    }
	
    return @"Unknown"; //if model name can't be read
#endif
}

+ (NSString *) currentSystemVersion {
#if TARGET_OS_IPHONE
	return [[UIDevice currentDevice] systemVersion];
	
#else
	NSDictionary * sv = [NSDictionary dictionaryWithContentsOfFile:@"/System/Library/CoreServices/SystemVersion.plist"];
	return [sv objectForKey:@"ProductVersion"];
#endif
}

+ (BOOL) systemVersionGreaterEqualTo:(NSString *) version {
	return ([[self currentSystemVersion] compare:version options:NSNumericSearch]!=NSOrderedAscending);
}

+ (BMFDeviceFamily) currentDeviceFamily {
#if TARGET_OS_IPHONE
	if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) {
		return BMFDeviceFamilyIPad;
	}
	else {
		return BMFDeviceFamilyIPhone;
	}
#else
	return BMFDeviceFamilyMac;
#endif
}

+ (BMFDeviceOrientation) currentDeviceOrientation {
#if TARGET_OS_IPHONE
	return (BMFDeviceOrientation)[[UIDevice currentDevice] orientation];
#else
	return BMFDeviceOrientationUnknown;
#endif
}

+ (BMFDeviceOrientationAxis) currentDeviceOrientationAxis {
	BMFDeviceOrientation orientation = [self currentDeviceOrientation];
	if (orientation==BMFDeviceOrientationLandscapeLeft || orientation==BMFDeviceOrientationLandscapeRight) {
		return BMFDeviceOrientationAxisLandscape;
	}
	else if (orientation==BMFDeviceOrientationPortrait || orientation==BMFDeviceOrientationPortraitUpsideDown) {
		return BMFDeviceOrientationAxisPortrait;
	}
	else {
		return BMFDeviceOrientationAxisUnknown;
	}
}

+ (BMFDeviceBatteryState) currentDeviceBatteryState {
#if TARGET_OS_IPHONE
	return (BMFDeviceBatteryState)[[UIDevice currentDevice] batteryState];
#else
	
	CFTypeRef               info;
    CFArrayRef              list;
    CFDictionaryRef         battery;
    
    info = IOPSCopyPowerSourcesInfo();
    if(info == NULL) return BMFDeviceBatteryStateUnknown;
	
    list = IOPSCopyPowerSourcesList(info);
    if(list == NULL) {
        CFRelease(info);
        return BMFDeviceBatteryStateUnknown;
    }
	
	BOOL connected = [(NSString*)[(__bridge NSDictionary*)battery objectForKey:@kIOPSPowerSourceStateKey] isEqualToString:@kIOPSACPowerValue];
	BOOL charging = [[(__bridge NSDictionary*)battery objectForKey:@kIOPSIsChargingKey] boolValue];
	
	CFRelease(list);
    CFRelease(info);
	
	if (charging) return BMFDeviceBatteryStateCharging;
	if (connected) return BMFDeviceBatteryStateFull;
	return BMFDeviceBatteryStateUnplugged;
	
#endif
}

@end
