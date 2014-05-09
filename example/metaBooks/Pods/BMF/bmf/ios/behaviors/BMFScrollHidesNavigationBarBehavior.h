//
//  BMFScrollHidesNavigationBarBehavior.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewControllerBehavior.h"

#import "BMFScrollViewViewControllerBehavior.h"

@interface BMFScrollHidesNavigationBarBehavior : BMFScrollViewViewControllerBehavior

/// 20 By default
@property (nonatomic, assign) CGFloat minimumBarHeight;


@end
