//
//  BMFTimerViewControllerBehavior.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 20/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewControllerBehavior.h"

#import "BMFTypes.h"

@interface BMFTimerViewControllerBehavior : BMFViewControllerBehavior

@property (nonatomic, assign) NSUInteger interval;
@property (nonatomic, copy) BMFActionBlock actionBlock;

@end
