//
//  VITWBlockList.m
//  Yellow iPhone
//
//  Created by José Manuel Sánchez on 28/08/13.
//  Copyright (c) 2013 Vitaminew. All rights reserved.
//

#import "BMFBlockList.h"

@interface BMFBlockList()

@property (nonatomic, strong) NSMutableArray *blocks;

@end

@implementation BMFBlockList

- (id)init
{
    self = [super init];
    if (self) {
        self.blocks = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSUInteger) add: (BMFCompletionBlock) block {
	[self.blocks addObject:block];
	return self.blocks.count-1;
}

- (void) remove: (BMFCompletionBlock) block {
	[self.blocks removeObject:block];
}

- (void) removeBlockAt:(NSUInteger) index {
	[self.blocks removeObjectAtIndex:index];
}

- (void) run:(id) result error:(NSError *) error {
	[self.blocks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		BMFCompletionBlock block = obj;
		block(result,error);
	}];
}

@end
