//
//  BMFDeviceValue.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 27/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFDeviceValue.h"

#import "NSString+BMF.h"

#import "BMFDevice.h"
#import "BMFTypes.h"

#import "BMFConditionalValue.h"

#import "BMFBlockCondition.h"

@interface BMFDeviceValue()

@property (nonatomic, strong) NSMutableDictionary *valuesDic;

@end

@implementation BMFDeviceValue

//- (instancetype) initWithDefaultValue:(id) value {
//	BMFAssertReturnNil(value);
//	
//	self = [super init];
//    if (self) {
//        self.defaultValue = value;
//		self.valuesDic = [NSMutableDictionary dictionary];
//    }
//    return self;
//}
//
//- (instancetype)init {
//	[NSException raise:@"BMFDeviceValue needs at least one value" format:@"Use initWithDefaultValue instead"];
//	return nil;
//}

- (void) setValue:(id)value forFamily:(BMFDeviceFamily) family {
	[self addValue:@(family) conditions:@[ [[BMFBlockCondition alloc] initWithBlock:^BOOL(id param) {
		return ([BMFDevice currentDeviceFamily]==family);
	}] ]];
}

- (void) setValue:(id)value forFamily:(BMFDeviceFamily) family orientationAxis:(BMFDeviceOrientationAxis) orientation {
	
	[self addValue:@(family) conditions:@[
										[[BMFBlockCondition alloc] initWithBlock:^BOOL(id param) {
											return ([BMFDevice currentDeviceFamily]==family);
										}],
										[[BMFBlockCondition alloc] initWithBlock:^BOOL(id param) {
											return ([BMFDevice currentDeviceOrientationAxis]==orientation);
										}],
										   ]];
	
//	NSMutableString *key = [[NSString BMF_stringWithInteger:family] mutableCopy];
//	[key appendString:@"_"];
//	[key appendString:[NSString BMF_stringWithInteger:orientation]];
//	
//	self.valuesDic[key] = value;
}

- (void) setValue:(id)value forFamily:(BMFDeviceFamily) family orientationAxis:(BMFDeviceOrientationAxis) orientation batteryState:(BMFDeviceBatteryState)batteryState {
	
	
	[self addValue:@(family) conditions:@[
										  [[BMFBlockCondition alloc] initWithBlock:^BOOL(id param) {
		return ([BMFDevice currentDeviceFamily]==family);
	}],
										  [[BMFBlockCondition alloc] initWithBlock:^BOOL(id param) {
		return ([BMFDevice currentDeviceOrientationAxis]==orientation);
	}],
										  
										  [[BMFBlockCondition alloc] initWithBlock:^BOOL(id param) {
		return ([BMFDevice currentDeviceBatteryState]==batteryState);
	}],

										  ]];

	
//	NSMutableString *key = [[NSString BMF_stringWithInteger:family] mutableCopy];
//	[key appendString:@"_"];
//	[key appendString:[NSString BMF_stringWithInteger:orientation]];
//	[key appendString:@"_"];
//	[key appendString:[NSString BMF_stringWithInteger:batteryState]];
//	
//	self.valuesDic[key] = value;
}

- (void) setValue:(id)value forFamily:(BMFDeviceFamily) family orientationAxis:(BMFDeviceOrientationAxis) orientation batteryState:(BMFDeviceBatteryState)batteryState model:(NSString *)model {
	
	
	[self addValue:@(family) conditions:@[
										  [[BMFBlockCondition alloc] initWithBlock:^BOOL(id param) {
		return ([BMFDevice currentDeviceFamily]==family);
	}],
										  [[BMFBlockCondition alloc] initWithBlock:^BOOL(id param) {
		return ([BMFDevice currentDeviceOrientationAxis]==orientation);
	}],
										  
										  [[BMFBlockCondition alloc] initWithBlock:^BOOL(id param) {
		return ([BMFDevice currentDeviceBatteryState]==batteryState);
	}],
										  
										  [[BMFBlockCondition alloc] initWithBlock:^BOOL(id param) {
		return ([BMFDevice currentDeviceModel]==model);
	}],
										  ]];
	
//	NSMutableString *key = [[NSString BMF_stringWithInteger:family] mutableCopy];
//	[key appendString:@"_"];
//	[key appendString:[NSString BMF_stringWithInteger:orientation]];
//	[key appendString:@"_"];
//	[key appendString:[NSString BMF_stringWithInteger:batteryState]];
//	[key appendString:@"_"];
//	[key appendString:model];
//	
//	self.valuesDic[key] = value;
}

/*- (id) currentValue {
	
	NSString *familyKey = [NSString BMF_stringWithInteger:[BMFDevice currentDeviceFamily]];
	NSString *orientationKey = [NSString BMF_stringWithInteger:[BMFDevice currentDeviceOrientationAxis]];
	NSString *batteryKey = [NSString BMF_stringWithInteger:[BMFDevice currentDeviceBatteryState]];
	NSString *modelKey = [BMFDevice currentDeviceModel];
	
	id finalValue = self.defaultValue;
	
	NSMutableString *key = [familyKey mutableCopy];
	if (self.valuesDic[key]) finalValue = self.valuesDic[key];
	
	[key appendString:@"_"];
	[key appendString:orientationKey];
	if (self.valuesDic[key]) finalValue = self.valuesDic[key];
	
	[key appendString:@"_"];
	[key appendString:batteryKey];
	if (self.valuesDic[key]) finalValue = self.valuesDic[key];
	
	[key appendString:@"_"];
	[key appendString:modelKey];
	if (self.valuesDic[key]) finalValue = self.valuesDic[key];
	
	return finalValue;
}*/


@end
