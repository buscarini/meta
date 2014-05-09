//
//  NSObject+BMFCast.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 09/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <objc/runtime.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

#define BMFAddDisposableProperty(TARGET,KEYPATH) \
	[(id)(TARGET) BMF_addDisposableProperty:@keypath(TARGET, KEYPATH)]

@interface NSObject (BMF)

+ (instancetype) BMF_cast:(id)from;

- (id) BMF_castWithProtocol:(Protocol *) protocol;

- (BOOL) BMF_isNotNull;

- (void) BMF_addDisposableProperty:(NSString *) keyPath;


@end
