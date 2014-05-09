//
//  BMFNavigationBarViewControllerBehavior.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFViewControllerBehaviorProtocol.h"

@interface BMFNavigationBarViewControllerBehavior : NSObject <BMFViewControllerBehaviorProtocol>

@property (nonatomic, weak) UIViewController *viewController;

/// YES by default
@property (nonatomic, assign) BOOL navigationBarHidden;

/// YES by default
@property (nonatomic, assign) BOOL restoreOnDisappear;

/// YES by default
@property (nonatomic, assign) BOOL animated;

@end
