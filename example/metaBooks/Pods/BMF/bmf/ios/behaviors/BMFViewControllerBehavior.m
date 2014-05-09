//
//  BMFViewControllerBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewControllerBehavior.h"

@implementation BMFViewControllerBehavior

- (instancetype) init {
    self = [super init];
    if (self) {
		[self performInit];
    }
    return self;
}

- (void) performInit { }

@end
