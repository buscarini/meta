//
//  BMFPresentViewControllerBehavior.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewControllerBehavior.h"

#import "BMFActivityProtocol.h"
#import "BMFItemTapBehavior.h"

@interface BMFRunActivityViewControllerBehavior : BMFItemTapBehavior

@property (nonatomic, strong) id<BMFActivityProtocol> activity;

@end
