//
//  BMFOnlineViewControllerBehavior.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 03/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"
#import "BMFViewControllerBehavior.h"

@interface BMFOnlineViewControllerBehavior : BMFViewControllerBehavior

@property (nonatomic, weak) UIViewController *object;

#warning Add loader
- (instancetype) initWithActionBlock:(BMFActionBlock) actionBlock;

@end
