//
//  NSObject+BMFCast.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "NSObject+BMF.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@implementation NSObject (BMF)

+ (instancetype) BMF_cast:(id)from {
	if ([from isKindOfClass:self]) {
        return from;
    }
    return nil;
}

- (id) BMF_castWithProtocol:(Protocol *) protocol {
	if ([self conformsToProtocol:protocol]) return self;
	return nil;
}

- (BOOL) BMF_isNotNull {
	return ((NSNull *)self!=[NSNull null]);
}

- (void) BMF_addDisposableProperty:(NSString *) keyPath {

	#if TARGET_OS_IPHONE
	
	@weakify(self);
	[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidReceiveMemoryWarningNotification object:nil] subscribeNext:^(id x) {
		@strongify(self);
		[self setValue:nil forKey:keyPath];
	}];
	
	#endif
}

@end
