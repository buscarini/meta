//
//  BMFViewControllerBehavior.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFViewControllerBehaviorProtocol.h"

@interface BMFViewControllerBehavior : NSObject <BMFViewControllerBehaviorProtocol>

@property (nonatomic, weak) UIViewController *object;

- (void) performInit;

@end
