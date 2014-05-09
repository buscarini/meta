
#import "BMFNotificationEvent.h"

#import "BMF.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACExtScope.h>

@implementation BMFNotificationEvent

- (instancetype) initWithName:(NSString *)name block:(BMFActionBlock) eventBlock {
	return [self initWithName:name object:nil block:eventBlock];
}

- (instancetype) initWithName:(NSString *)name object:(id)object block:(BMFActionBlock) eventBlock {
	BMFAssertReturnNil(name);
	
	self = [super init];
	if (self) {
		@weakify(self);
		[[[NSNotificationCenter defaultCenter] rac_addObserverForName:name object:object] subscribeNext:^(id x) {
			@strongify(self);
			if (self.eventBlock) self.eventBlock(self);
		}];
	}
	return self;
	
}

@end