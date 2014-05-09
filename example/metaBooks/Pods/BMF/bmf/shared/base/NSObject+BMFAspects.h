//
//  NSObject+BMFAspect.h
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 25/04/14.
//
//

#import <Foundation/Foundation.h>

#import "BMFAspectProtocol.h"
#import "BMFArrayProxy.h"

@interface NSObject (BMFAspects)

@property (nonatomic, strong) BMFArrayProxy *BMF_proxy;

- (void) BMF_addAspect:(id<BMFAspectProtocol>) aspect;
- (void) BMF_removeAspect:(id<BMFAspectProtocol>) aspect;

@end
