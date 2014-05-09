//
//  BMFSelectorEvent.m
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/04/14.
//
//

#import "BMFSelectorEvent.h"

#import "BMF.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@implementation BMFSelectorEvent

- (instancetype) initWithObject:(id) object selector:(SEL) selector {
	BMFAssertReturnNil(object);
	BMFAssertReturnNil(selector);
	
	self = [super init];
	if (self) {
		@weakify(self);
		[[object rac_signalForSelector:selector] subscribeNext:^(id x) {
			@strongify(self);
			if (self.eventBlock) self.eventBlock(self);
		}];
	}
	
	return self;
}

- (instancetype)init {
	BMFInvalidInit(initWithObject:selector:);
}


@end
