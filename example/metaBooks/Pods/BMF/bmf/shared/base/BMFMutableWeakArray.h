//
//  BMFMutableWeakArray.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMFMutableWeakArray : NSMutableArray

- (id) objectAtIndexedSubscript:(NSUInteger) index;
- (void) setObject:(id)object atIndexedSubscript:(NSUInteger)idx;

- (void) insertObject:(id) object atIndex:(NSUInteger)index;
- (void) insertObjects:(NSArray *) objects atIndexes:(NSIndexSet *)indexes;

- (void) addObject:(id) object;
- (id) objectAtIndex:(NSUInteger)index;

- (void) removeLastObject;

- (NSUInteger) count;

@end
