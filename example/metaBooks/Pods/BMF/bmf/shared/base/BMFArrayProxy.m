//
//  BMFProxy.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFArrayProxy.h"

#import "BMF.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BMFArrayProxy()

@property (nonatomic, strong) NSMutableSet *destinationObjects;
@property (nonatomic, strong) RACSubject *destinationsSignal;

@end

@implementation BMFArrayProxy

- (instancetype)init {
    if (self) {
        self.destinationObjects = [NSMutableSet set];
		_destinationsSignal = [RACSubject subject];
    }
    return self;
}
+ (instancetype)new {
	return [[BMFArrayProxy alloc] init];
}

//+ (RACSubject *) destinationsSignal {
//	return self.destinationsSignal;
//}

- (void) dealloc {
	[(RACSubject *)self.destinationsSignal sendCompleted];
}

#if TARGET_OS_IPHONE
- (void) setViewController:(UIViewController *)viewController {
	for (id obj in self.destinationObjects) {
		if ([obj respondsToSelector:@selector(setViewController:)]) {
			[obj setViewController:viewController];
		}
	}
	
	_viewController = viewController;
}
#endif

- (void) addDestinationObject:(id) object {
	
	BMFAssertReturn(object);
	
	#if TARGET_OS_IPHONE

	if ([object respondsToSelector:@selector(setViewController:)]) {
		[object setViewController:self.viewController];
	}
	
#endif
	
	[self.destinationObjects addObject:object];
	
	[(RACSubject *)self.destinationsSignal sendNext:_destinationObjects];
	
//	if (self.destinationsChangedBlock) self.destinationsChangedBlock(self);
}

- (void) removeDestinationObject:(id) object {
	if (object) [self.destinationObjects removeObject:object];
	
	[(RACSubject *)self.destinationsSignal sendNext:_destinationObjects];

//	if (self.destinationsChangedBlock) self.destinationsChangedBlock(self);
}

- (BOOL)respondsToSelector:(SEL)aSelector {
	for (id obj in self.destinationObjects) {
		if ([obj respondsToSelector:aSelector]) return YES;
	}
	
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
	NSMethodSignature *sig = nil;
	for(id obj in self.destinationObjects) {
		sig = [obj methodSignatureForSelector:sel];
		if (sig) break;
	}

	return sig;
}

- (void)forwardInvocation:(NSInvocation *)inv {
	for(id obj in self.destinationObjects) {
		if ([obj respondsToSelector:inv.selector]) {
			[inv invokeWithTarget:obj];	
		}
	}		
}

@end
