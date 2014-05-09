//
//  BMFCoreDataStoreFactory.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 31/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFIOSCoreDataStoreFactory.h"

#import "BMFFRCDataStore.h"

#import <CoreData/CoreData.h>

@implementation BMFIOSCoreDataStoreFactory

+ (void)load {
	[self register];
}

- (id<BMFDataReadProtocol>) dataStoreWithParameter:(id) input sender:(id) sender {
	if ([input isKindOfClass:[NSFetchedResultsController class]]) {
		return [self frcDataStore:input sender:sender];
	}
	
	return nil;
}

- (id<BMFDataReadProtocol>) frcDataStore:(NSFetchedResultsController *) fr sender:(id) sender {
	return [[BMFFRCDataStore alloc] initWithController:fr];
}

@end
