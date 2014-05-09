//
//  TNFRDataStore.m
//  DataSources
//
//  Created by José Manuel Sánchez on 05/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFFRCDataStore.h"

@implementation BMFFRCDataStore

- (instancetype)initWithController:(NSFetchedResultsController *)fr {
	
	BMFAssertReturnNil(fr);
	
    self = [super init];
    if (self) {
        _fr = fr;
		_fr.delegate = self;
		[self loadData:nil];
    }
    return self;
}

- (instancetype)init {
	[NSException raise:@"Needs a fr" format:@"Use initWithController: instead"];
    return nil;
}

- (NSInteger) numberOfSections {
	if (!self.fr.fetchedObjects || self.fr.fetchedObjects.count==0) [self loadData:nil];
	return [self.fr.sections count];
}

- (NSInteger) numberOfRowsInSection:(NSUInteger) section {
	id<NSFetchedResultsSectionInfo> info = self.fr.sections[section];
	// This is needed to avoid a bug where merging contexts will ignore the fetchlimit and result in a crash
	NSInteger numObjects = info.numberOfObjects;
	if (numObjects>self.fr.fetchRequest.fetchLimit && self.fr.fetchRequest.fetchLimit>0) {
		numObjects = self.fr.fetchRequest.fetchLimit;
	}
    return numObjects;
}

- (NSString *) titleForSection:(NSUInteger)section kind:(BMFViewKind)kind {
	if (kind==BMFViewKindSectionHeader) {
		id<NSFetchedResultsSectionInfo> info = self.fr.sections[section];
		return info.name;
	}
	
	return nil;
}

- (id) itemAt:(NSInteger) section row:(NSInteger) row {
	 return [self.fr objectAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

- (id) itemAt:(NSIndexPath *) indexPath {
	return [self itemAt:indexPath.section row:indexPath.row];
}

- (NSIndexPath *) indexOfItem:(id) item {
	NSUInteger row = [self.allItems indexOfObject:item];
	if (row==NSNotFound) return nil;
	return [NSIndexPath indexPathForRow:row inSection:0];
}

- (NSArray *) allItems {
	return self.fr.fetchedObjects;
}

- (BOOL) isEmpty {
	return (self.fr.fetchedObjects.count==0);
}

#pragma mark NSFetchedResultsController

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataWillChangeNotification object:self];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	
    switch(type) {
        case NSFetchedResultsChangeInsert:
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataSectionInsertedNotification object:self userInfo:@{ @"index" : @(sectionIndex) }];
            break;
			
        case NSFetchedResultsChangeDelete:
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataSectionDeletedNotification object:self userInfo:@{ @"index" : @(sectionIndex) }];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath {
	
    switch(type) {
			
        case NSFetchedResultsChangeInsert:
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataInsertedNotification object:self userInfo:@{ @"indexPath" : newIndexPath }];
//			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataInsertedNotification object:newIndexPath];
            break;
			
        case NSFetchedResultsChangeDelete:
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataDeletedNotification object:self userInfo:@{ @"indexPath" : indexPath }];
            break;
			
        case NSFetchedResultsChangeUpdate:
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataUpdatedNotification object:self userInfo:@{ @"indexPath" : indexPath }];
			
            break;
			
        case NSFetchedResultsChangeMove:
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataDeletedNotification object:self userInfo:@{ @"indexPath" : indexPath }];
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataInsertedNotification object:self userInfo:@{ @"indexPath" : newIndexPath }];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataDidChangeNotification object:self];

	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataBatchChangeNotification object:self];
}

//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//	[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataChangedNotification object:self];
//}

#pragma mark TNNode

- (BOOL) performProcess:(id)input completion:(BMFNodeProcessCompletionBlock)completionBlock {
	return [self loadData:completionBlock];
}

- (BOOL) loadData:(BMFCompletionBlock) completionBlock {
	NSError *error = nil;
	BOOL result = [self.fr performFetch:&error];
	
	if (result) _loaded = YES;
	
	if (completionBlock) completionBlock(self.fr.fetchedObjects,error);
	
	return result;
}

@end
