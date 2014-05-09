//
//  BMFPulseActivity.m
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/04/14.
//
//

#import "BMFPulseActivity.h"

#import "BMFEvent.h"

#import "BMF.h"

#import <ReactiveCocoa/RACEXTScope.h>

@interface BMFPulseActivity()

@property (nonatomic, assign) BOOL enabled;

@end

@implementation BMFPulseActivity

- (instancetype) initWithEnable:(BMFEvent *) enableEvent run:(BMFEvent *) runEvent value:(BMFActivity *)value {
	
	BMFAssertReturnNil(enableEvent);
	BMFAssertReturnNil(runEvent);
	BMFAssertReturnNil(value);
	
	self = [super init];
	if (self) {
		_enableEvent = enableEvent;
		_runEvent = runEvent;
		self.value = value;
		
		@weakify(self);
		_enableEvent.eventBlock = ^(BMFEvent *event) {
			@strongify(self);
			self.enabled = YES;
		};
		
		_runEvent.eventBlock = ^(BMFEvent *event) {
			@strongify(self);
			if (self.enabled) {
				[self.value run:^(id result, NSError *error) {
					if (self.completionBlock) self.completionBlock(result,error);
					self.enabled = NO;
				}];
			}
		};
	}
	
	return self;
}

- (instancetype)init {
	BMFInvalidInit(initWithEnable:run:value:);
}

@end
