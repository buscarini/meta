//
//  TNArrayDataStore.m
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFArrayDataStore.h"

@interface BMFArrayDataStore()

@property (nonatomic, strong) NSMutableArray *storedItems;

@end

@implementation BMFArrayDataStore

#pragma mark TNDataStoreProtocol

- (void) startAdding {
	self.storedItems = [NSMutableArray array];
	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataWillChangeNotification object:self];
}

- (BOOL) addItem:(id) item {
	[self.storedItems addObject:item];
	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataInsertedNotification object:self userInfo:@{ @"indexPath" : [NSIndexPath BMF_indexPathForRow:self.storedItems.count-1 inSection:0] }];
	return YES;
}

- (void) endAdding {
	if (self.dataChangedBlock) self.dataChangedBlock(self.items,nil);
	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataDidChangeNotification object:self];
}

- (void) setItems:(NSArray *)items {
	_storedItems = [items mutableCopy];

	if (self.dataChangedBlock) self.dataChangedBlock(self.items,nil);
		
	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataBatchChangeNotification object:self];
}

- (NSArray *) items {
	return [_storedItems copy];
}

- (void) removeItem:(id) item {
	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataWillChangeNotification object:self];

	NSInteger index = [self.storedItems indexOfObject:item];
	[self.storedItems removeObjectAtIndex:index];
	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataDeletedNotification object:self userInfo:@{ @"indexPath" : [NSIndexPath BMF_indexPathForRow:index inSection:0] }];

	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataDidChangeNotification object:self];
}

- (void) removeAllItems {
	[self.storedItems removeAllObjects];

	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataBatchChangeNotification object:self];
}

#pragma mark TNDataReadProtocol

- (NSInteger) numberOfSections {
	if (self.storedItems.count>0) return 1;
	return 0;
}

- (NSInteger) numberOfRowsInSection:(NSUInteger) section {
	return [self.storedItems count];
}

- (NSString *) titleForSection:(NSUInteger)section kind:(BMFViewKind)kind {
	if (kind==BMFViewKindSectionHeader) return self.sectionHeaderTitle;
	return self.sectionFooterTitle;
}

- (id) itemAt:(NSInteger) section row:(NSInteger) row {
	BMFAssertReturnNil(section==0);
	BMFAssertReturnNil(row>=0);
	BMFAssertReturnNil(row<self.storedItems.count);
	
	return self.storedItems[row];
}

- (id) itemAt:(NSIndexPath *) indexPath {
	return [self itemAt:indexPath.BMF_section row:indexPath.BMF_row];
}

- (NSIndexPath *) indexOfItem:(id) item {
	if (!item) return nil;
	NSUInteger row = [self.allItems indexOfObject:item];
	if (row==NSNotFound) return nil;
	return [NSIndexPath BMF_indexPathForRow:row inSection:0];
}


- (NSArray *) allItems {
	return self.storedItems;
}

- (BOOL) isEmpty {
	return (self.storedItems.count==0);
}

#pragma mark TNNode

- (BOOL) performProcess:(id)input completion:(BMFNodeProcessCompletionBlock)completionBlock {
	if (!input) return NO;
	
	[self startAdding];
	
	BOOL result = YES;
	
	if ([input isKindOfClass:[NSArray class]]) {
		for (id object in input) {
			result &= [self addItem:object];
		}
	}
	else {
		result &=[self addItem:input];
	}
	
	completionBlock(self.allItems,nil);
	
	[self endAdding];
	
	return result;
}

@end
