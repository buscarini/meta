//
//  BMFCondition.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFCondition.h"

#import "BMFBlockCondition.h"

@implementation BMFCondition

- (BOOL) evaluate {
	[NSException raise:@"Subclasses must implement evaluate" format:@"%@",self];
	return NO;
}

+ (BMFCondition *) not:(BMFCondition *) condition {
	BMFCondition *result = [[BMFBlockCondition alloc] initWithBlock:^BOOL(id parameter){
		return ![condition evaluate];
	}];
	
	__weak BMFCondition *wresult = result;
	condition.inputsChangedBlock = ^(id input) {
		wresult.inputsChangedBlock(wresult);
	};
	
	return result;
}

@end

@implementation BMFTrueCondition

- (BOOL) evaluate { return YES; }

@end

@implementation BMFFalseCondition

- (BOOL) evaluate { return NO; }

@end
