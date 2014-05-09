//
//  BMFMutableWeakArray.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFMutableWeakArray.h"
#import "BMFWeakObject.h"

@interface BMFMutableWeakArray()

@property (nonatomic, strong) NSMutableArray *array;

@end


@implementation BMFMutableWeakArray

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.array = [NSMutableArray array];
    }
    return self;
}

- (id) objectAtIndexedSubscript:(NSUInteger) index {
	BMFWeakObject *obj = [self.array objectAtIndexedSubscript:index];
	return obj.object;
}

- (void) setObject:(id)object atIndexedSubscript:(NSUInteger)idx {
	BMFWeakObject *weak = [[BMFWeakObject alloc] initWithObject:object];
	[self.array setObject:weak atIndexedSubscript:idx];
}

- (void) insertObject:(id) object atIndex:(NSUInteger)index {
	BMFWeakObject *weak = [[BMFWeakObject alloc] initWithObject:object];
	[self.array insertObject:weak atIndex:index];
}

- (void) insertObjects:(NSArray *) objects atIndexes:(NSIndexSet *)indexes {
	NSMutableArray *weakObjects = [NSMutableArray array];
	for (id object in objects) {
		BMFWeakObject *weak = [[BMFWeakObject alloc] initWithObject:object];
		[weakObjects addObject:weak];
	}
	
	[self.array insertObjects:weakObjects atIndexes:indexes];
}

- (void) addObject:(id) object {
	BMFWeakObject *weak = [[BMFWeakObject alloc] initWithObject:object];
	[self.array addObject:weak];
}

- (id) objectAtIndex:(NSUInteger)index {
	BMFWeakObject *weak = [self.array objectAtIndex:index];
	return weak.object;
}

- (void) removeLastObject {
	
	[self purgeEmptyObjects];
	
	[self.array removeLastObject];
}

- (NSUInteger) count {
	[self purgeEmptyObjects];
	
	return self.array.count;
}

- (void) purgeEmptyObjects {
	NSMutableArray *objectsToDelete = [NSMutableArray array];
	NSArray *arrayCopy = [self.array copy];
	for (BMFWeakObject *weak in arrayCopy) {
		if (!weak.object) {
			[objectsToDelete addObject:weak];
		}
	}
	
	[self.array removeObjectsInArray:objectsToDelete];
}

@end
