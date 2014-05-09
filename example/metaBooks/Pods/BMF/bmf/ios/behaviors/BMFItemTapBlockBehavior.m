//
//  BMFItemTapBlockBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFItemTapBlockBehavior.h"

#import "BMFDataSourceProtocol.h"
#import "BMFDataReadProtocol.h"

@implementation BMFItemTapBlockBehavior

- (instancetype) initWithTapBlock:(BMFActionBlock)tapBlock {
	BMFAssertReturnNil(tapBlock);
	
    self = [super init];
    if (self) {
        self.itemTapBlock = tapBlock;
		self.deselectItemOnTap = YES;
    }
    return self;
}

- (instancetype)init {
	[NSException raise:@"Tap block is required" format:@"use initWithTapBlock: instead"];
	return nil;
}

- (void) itemTapped:(id)item {
	self.itemTapBlock(item);
}

@end
