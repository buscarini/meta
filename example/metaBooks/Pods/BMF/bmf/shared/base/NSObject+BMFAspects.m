//
//  NSObject+BMFAspect.m
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 25/04/14.
//
//

#import "NSObject+BMFAspects.h"

#import "BMFTypes.h"

#import <objc/runtime.h>

@implementation NSObject (BMFAspects)

@dynamic BMF_proxy;

- (void)setBMF_proxy:(BMFArrayProxy *)proxy {
	objc_setAssociatedObject(self, @selector(BMF_proxy), proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BMFArrayProxy *) BMF_proxy {
    return objc_getAssociatedObject(self, @selector(BMF_proxy));
}

- (void) BMF_addAspect:(id<BMFAspectProtocol>) aspect {
	BMFAssertReturn(aspect);
	
	if ([aspect respondsToSelector:@selector(setObject:)]) aspect.object = self;
	if (!self.BMF_proxy) self.BMF_proxy = [BMFArrayProxy new];
	
	[self.BMF_proxy addDestinationObject:aspect];
}

- (void) BMF_removeAspect:(id<BMFAspectProtocol>) aspect {
	if (!aspect) return;
	
	[self.BMF_proxy removeDestinationObject:aspect];
}

@end
