//
//  BMFCoreDataStoreFactory.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 31/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFCoreDataStoreFactory.h"

#import "BMFFRDataStore.h"

#import <CoreData/CoreData.h>

@implementation BMFCoreDataStoreFactory

+ (void)load {
	[self register];
}

- (id<BMFDataReadProtocol>) dataStoreWithParameter:(id) input sender:(id) sender {
	return nil;
}

- (id<BMFDataReadProtocol>) dataStoreWithParameters:(NSArray *) parameters sender:(id) sender {
	
	id first = parameters.firstObject;
	id second = nil;
	if (parameters.count>1) second = parameters[1];
	
	if ([first isKindOfClass:[NSFetchRequest class]] && [second isKindOfClass:[NSManagedObjectContext class]]) {
		return [self frDataStore:first context:second sender:sender];
	}
	
	return nil;
}

- (id<BMFDataReadProtocol>) frDataStore:(NSFetchRequest *) fr context:(NSManagedObjectContext *) context sender:(id) sender {
	return [[BMFFRDataStore alloc] initWithFR:fr context:context];
}

@end
