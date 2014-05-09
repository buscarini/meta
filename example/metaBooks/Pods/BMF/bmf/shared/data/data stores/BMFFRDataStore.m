//
//  BMFFRDataStore.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFFRDataStore.h"

#import <CoreData/CoreData.h>

@interface BMFFRDataStore ()

@property (nonatomic, strong) NSArray *fetchedObjects;

@end

@implementation BMFFRDataStore

- (id)initWithFR:(NSFetchRequest *)fr context:(NSManagedObjectContext *) context {
	
	BMFAssertReturnNil([fr isKindOfClass:[NSFetchRequest class]] && context);
		
    self = [super init];
    if (self) {
        _fr = fr;
		[self loadData:nil];
    }
    return self;
}

- (id)init {
	[NSException raise:@"Needs a fr" format:@"Use initWithFR: instead"];
    return nil;
}

- (NSInteger) numberOfSections {
	return 1;
}

- (NSInteger) numberOfRowsInSection:(NSUInteger) section {
    return self.fetchedObjects.count;
}

- (NSString *) titleForSection:(NSUInteger)section kind:(BMFViewKind)kind {
	if (kind==BMFViewKindSectionHeader) return self.sectionHeaderTitle;
	return self.sectionFooterTitle;
}

- (id) itemAt:(NSInteger) section row:(NSInteger) row {
	if (row>=self.fetchedObjects.count) return nil;
	return self.fetchedObjects[row];
}

- (id) itemAt:(NSIndexPath *) indexPath {
	#if TARGET_OS_IPHONE
	return [self itemAt:indexPath.section row:indexPath.row];
#else
	return [self itemAt:0 row:[indexPath indexAtPosition:0]];
#endif
}

- (NSIndexPath *) indexOfItem:(id) item {
	NSUInteger row = [self.allItems indexOfObject:item];
	if (row==NSNotFound) return nil;
	
#if TARGET_OS_IPHONE
	return [NSIndexPath indexPathForRow:row inSection:0];
#else
	return [NSIndexPath indexPathWithIndex:row];
#endif
}

- (NSArray *) allItems {
	return self.fetchedObjects;
}

- (BOOL) isEmpty {
	return (self.fetchedObjects.count==0);
}

#pragma mark TNNode

- (BOOL) performProcess:(id)input completion:(BMFNodeProcessCompletionBlock)completionBlock {
	return [self loadData:completionBlock];
}

- (BOOL) loadData:(BMFCompletionBlock) completionBlock {
	NSError *error = nil;
	self.fetchedObjects = [self.context executeFetchRequest:self.fr error:&error];
	
	if (!error) _loaded = YES;
	
	if (completionBlock) completionBlock(self.fetchedObjects,error);
	
	return _loaded;
}

@end
