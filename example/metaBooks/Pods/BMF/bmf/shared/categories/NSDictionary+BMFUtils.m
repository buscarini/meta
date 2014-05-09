//
//  NSDictionary+BMFUtils.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 30/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "NSDictionary+BMFUtils.h"

@implementation NSDictionary (BMFUtils)

- (id) BMF_firstValueForKeys:(NSArray *) keys {
	id result = nil;
	for (NSString *key in keys) {
		result = self[key];
		if (result) return result;
	}
	return result;
}

@end
