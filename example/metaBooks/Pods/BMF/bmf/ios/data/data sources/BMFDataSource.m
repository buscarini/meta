//
//  BMFDataSource.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 04/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFDataSource.h"

#import "BMF.h"

@implementation BMFDataSource

- (instancetype) initWithDataStore:(id<BMFDataReadProtocol>) dataStore {
	
	BMFAssertReturnNil(dataStore);
	
    self = [super init];
    if (self) {
        self.dataStore = dataStore;
    }
    return self;
}

- (id)init {
	[NSException raise:@"Data store is needed. Use initWithDataStore: instead" format:nil];
	return nil;
}

#pragma mark BMFDataReadProtocol

- (NSInteger) numberOfSections {
	return [self.dataStore numberOfSections];
}

- (NSInteger) numberOfRowsInSection:(NSUInteger) section {
	return [self.dataStore numberOfRowsInSection:section];
}

- (NSString *) titleForSection:(NSUInteger)section kind:(BMFViewKind)kind {
	return [self.dataStore titleForSection:section kind:kind];
}

- (id) itemAt:(NSInteger) section row:(NSInteger) row {
	return [self.dataStore itemAt:section row:row];
}

- (id) itemAt:(NSIndexPath *)indexPath {
	return [self.dataStore itemAt:indexPath];
}

- (NSIndexPath *) indexOfItem:(id)item {
	return [self.dataStore indexOfItem:item];
}

- (NSArray *) allItems {
	return [self.dataStore allItems];
}

- (BOOL) isEmpty {
	return [self.dataStore isEmpty];
}

@end
