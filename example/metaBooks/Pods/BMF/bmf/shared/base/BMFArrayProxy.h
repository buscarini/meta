//
//  BMFProxy.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "BMFTypes.h"

#if TARGET_OS_IPHONE
#import "BMFViewControllerBehaviorProtocol.h"
#endif

@class RACSignal;

@interface BMFArrayProxy : NSProxy
#if TARGET_OS_IPHONE
 <BMFViewControllerBehaviorProtocol>
#endif

#if TARGET_OS_IPHONE
@property (nonatomic, weak) UIViewController *viewController;
#endif

@property (nonatomic, readonly) NSMutableSet *destinationObjects;

/// This block is called every time a destination object is added or removed. Here you should assign nil as delegate, and then assign the delegate again. This is needed because Apple caches the response of respondsToSelector on assignment
//@property (nonatomic, copy) BMFActionBlock destinationsChangedBlock;

/// Signal that sends a next every time the destinationObjects change
@property (nonatomic, readonly) RACSignal *destinationsSignal;
//+ (RACSignal *) destinationsSignal;

- (void) addDestinationObject:(id) object;
- (void) removeDestinationObject:(id) object;

- (instancetype)init;
+ (instancetype)new;

@end
