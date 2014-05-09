//
//  BMFFlattenSectionsDataStore.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFFlattenSectionsDataStore.h"

#import "BMFTypes.h"

@implementation BMFFlattenSectionsDataStore

#pragma mark BMFDataStoreProtocol

- (NSInteger) numberOfSections {
	
	for (id<BMFDataReadProtocol> dataStore in self.dataStores) {
		for (int i=0;i<[dataStore numberOfSections];i++) {
			if ([dataStore numberOfRowsInSection:i]>0) return 1;
		}
	}
	
	return 0;
}

-(NSString *) titleForSection:(NSUInteger)section kind:(BMFViewKind)kind {
	if (kind==BMFViewKindSectionHeader) return self.sectionHeaderTitle;
	else if (kind==BMFViewKindSectionFooter) return self.sectionFooterTitle;
	return nil;
}

- (NSInteger) numberOfRowsInSection:(NSUInteger) section {
	BMFAssertReturnZero(section>=0);
	BMFAssertReturnZero(section<self.numberOfSections);

	NSInteger numRows = 0;
	for (id<BMFDataReadProtocol> dataStore in self.dataStores) {
		for (int i=0;i<[dataStore numberOfSections];i++) {
			numRows += [dataStore numberOfRowsInSection:i];
		}
	}
	
	return numRows;
}

- (id) itemAt:(NSInteger) section row:(NSInteger) row {
	BMFAssertReturnNil(section==0);
	BMFAssertReturnNil(row>=0);
	BMFAssertReturnNil(row<[self numberOfRowsInSection:section]);
	
	for (id<BMFDataReadProtocol> dataStore in self.dataStores) {
		for (int i=0;i<[dataStore numberOfSections];i++) {
			NSInteger numRows = [dataStore numberOfRowsInSection:i];
			if (row<numRows) {
				return [dataStore itemAt:i row:row];
			}
			
			row -= numRows;
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
	NSInteger row = 0;
	
	for (id<BMFDataReadProtocol> dataStore in self.dataStores) {
		NSIndexPath *indexPath = [dataStore indexOfItem:item];
		if (indexPath) {
			row += indexPath.BMF_row;
			found = YES;
			break;
		}
		else {
			for (int i=0;i<[dataStore numberOfSections];i++) {
				row += [dataStore numberOfRowsInSection:i];
			}
		}
	}
	
	if (!found) return nil;
	
	return [NSIndexPath BMF_indexPathForRow:row inSection:0];
}

- (NSArray *) allItems {
	NSMutableArray *results = [NSMutableArray array];
	for (id<BMFDataReadProtocol> dataStore in self.dataStores) {
		[results addObjectsFromArray:[dataStore allItems]];
	}
	
	return results;
}


@end
