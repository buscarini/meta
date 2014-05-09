//
//  BMFSystemVersionCondition.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFSystemVersionCondition.h"

#import "BMFTypes.h"
#import "BMFDevice.h"

@implementation BMFSystemVersionCondition

- (instancetype) initWithSystemVersion:(NSString *) systemVersion comparisonType:(BMFConditionComparisonType) comparisonType {
	BMFAssertReturnNil(systemVersion.length>0);
	
	self = [super init];
    if (self) {
		_systemVersion = [systemVersion copy];
		_comparisonType = comparisonType;
    }
    return self;
}

- (instancetype) init {
	BMFInvalidInit(initWithSystemVersion:comparisonType:);
}

- (BOOL) evaluate {
	
	NSString *version = [BMFDevice currentSystemVersion];
	
	NSComparisonResult comparisonResult = [version compare:_systemVersion options:NSNumericSearch];
	
	if ( (comparisonResult==NSOrderedSame) &&
		(_comparisonType==BMFConditionEqualComparisonType ||
		 _comparisonType==BMFConditionLessThanOrEqualComparisonType ||
		 _comparisonType==BMFConditionGreaterThanOrEqualComparisonType) ) {
			return YES;
		}
	
	if ( (comparisonResult==NSOrderedAscending) &&
		(_comparisonType==BMFConditionDifferentComparisonType ||
		 _comparisonType==BMFConditionGreaterThanComparisonType ||
		 _comparisonType==BMFConditionGreaterThanOrEqualComparisonType) ) {
			return YES;
		}
	
	if ( (comparisonResult==NSOrderedDescending) &&
		(_comparisonType==BMFConditionDifferentComparisonType ||
		 _comparisonType==BMFConditionLessThanComparisonType ||
		 _comparisonType==BMFConditionLessThanOrEqualComparisonType) ) {
			return YES;
		}
	
	return NO;
}

@end
