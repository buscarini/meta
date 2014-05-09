//
//  BMFCompoundEvent.m
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/04/14.
//
//

#import "BMFCompoundEvent.h"

#import "BMF.h"

#import <ReactiveCocoa/RACEXTScope.h>

@interface BMFCompoundEvent()

@property (nonatomic, strong) NSArray *events;

@end

@implementation BMFCompoundEvent

- (instancetype) initWithEvents:(NSArray *) events {
	BMFAssertReturnNil(events.count>0);
	self = [super init];
	if (self) {
		_events = events;
		for (BMFEvent *event in events) {
			@weakify(self);
			event.eventBlock = ^(BMFEvent *event) {
				@strongify(self);
				if (self.eventBlock) self.eventBlock(self);
			};
		}
	}
	return self;
}

- (instancetype)init {
	BMFInvalidInit(initWithEvents:);
}

@end
