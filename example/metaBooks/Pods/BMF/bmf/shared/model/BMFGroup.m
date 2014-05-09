//
//  BMFGroup.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFGroup.h"

@implementation BMFGroup

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.children = [NSMutableArray array];
    }
    return self;
}

- (void) setParent:(BMFGroup *)parent {
	if (![parent.children containsObject:self])	[parent.children addObject:self];
}

@end
