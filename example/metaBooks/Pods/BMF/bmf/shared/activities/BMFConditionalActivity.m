//
//  BMFConditionalActivity.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFConditionalActivity.h"

#import "BMFTypes.h"

@implementation BMFConditionalActivity

- (instancetype) initWithDefaultActivity:(id<BMFActivityProtocol>) defaultActivity {
	self = [super initWithDefaultValue:defaultActivity];
	if (self) {
		
	}
	
	return self;
}

- (BOOL) isAvailable {
	return [self.defaultValue isAvailable];
}

- (void) run: (BMFCompletionBlock) completionBlock {
	id<BMFActivityProtocol> activity = [self currentValue];
	
	#if TARGET_OS_IPHONE
	if ([activity respondsToSelector:@selector(setViewController:)]) activity.viewController = self.viewController;
	#endif
	
	activity.value = self.value;
	
	[activity run:completionBlock];
}


@end
