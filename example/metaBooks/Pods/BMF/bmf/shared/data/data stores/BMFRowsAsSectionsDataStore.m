//
//  BMFRowsAsSectionsDataStore.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFRowsAsSectionsDataStore.h"

#import "BMFTypes.h"

@implementation BMFRowsAsSectionsDataStore

#pragma mark BMFDataStoreProtocol

- (NSInteger) numberOfSections {
	
	NSInteger numSections = 0;
	for (id<BMFDataReadProtocol> dataStore in self.dataStores) {
		for (int i=0;i<[dataStore numberOfSections];i++) {
			numSections += [dataStore numberOfRowsInSection:i];
		}
	}
	
	return numSections;
}

-(NSString *) titleForSection:(NSUInteger)section kind:(BMFViewKind)kind {
	return nil;
}

- (NSInteger) numberOfRowsInSection:(NSUInteger) section {
	BMFAssertReturnZero(section>=0);
	BMFAssertReturnZero(section<self.numberOfSections);
	return 1;
}

- (id) itemAt:(NSInteger) section row:(NSInteger) row {
	BMFAssertReturnNil(section>=0);
	BMFAssertReturnNil(section<self.numberOfSections);
	BMFAssertReturnNil(row==0);

	for (id<BMFDataReadProtocol> dataStore in self.dataStores) {
		for (int i=0;i<[dataStore numberOfSections];i++) {
			NSInteger numRows = [dataStore numberOfRowsInSection:i];
			if (section<numRows) {
				return [dataStore itemAt:i row:section];
			}
			
			section -= numRows;
		}
	}
	
	return nil;
}


- (id) itemAt:(NSIndexPath *) indexPath {
	return [self itemAt:indexPath.BMF_section row:indexPath.BMF_row];
}

- (NSIndexPath *) indexOfItem:(id) item {
	
	if (!item) return nil;
	
	BOOL found = NO;
	NSInteger section = 0;
	
	for (id<BMFDataReadProtocol> dataStore in self.dataStores) {
		NSIndexPath *indexPath = [dataStore indexOfItem:item];
		if (indexPath) {
			section += indexPath.BMF_row;
			found = YES;
			break;
		}
		else {
			for (int i=0;i<[dataStore numberOfSections];i++) {
				section += [dataStore numberOfRowsInSection:i];
			}
		}
	}
	
	if (!found) return nil;
	
	return [NSIndexPath BMF_indexPathForRow:0 inSection:section];
}

- (NSArray *) allItems {
	NSMutableArray *results = [NSMutableArray array];
	for (id<BMFDataReadProtocol> dataStore in self.dataStores) {
		[results addObjectsFromArray:[dataStore allItems]];
	}
	
	return results;
}


@end
