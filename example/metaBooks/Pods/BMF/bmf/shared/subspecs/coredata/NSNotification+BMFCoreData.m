//
//  NSNotification+BMFCoreData.m
//  ExampleMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 16/04/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import "NSNotification+BMFCoreData.h"

#import <CoreData/CoreData.h>

@implementation NSNotification (BMFCoreData)

- (NSDictionary *) BMF_changesInObjectIDs:(NSArray *) objectIds {

	NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
	
	NSDictionary *ui = [self userInfo];

	NSArray *interestingKeys = @[ NSUpdatedObjectsKey, NSDeletedObjectsKey, NSInsertedObjectsKey ];
	for (NSString *key in interestingKeys) {
		BMFNotificationChangeType changeType = BMFNotificationDeletedChangeType;
		if ([key isEqualToString:NSUpdatedObjectsKey]) changeType = BMFNotificationUpdatedChangeType;
		if ([key isEqualToString:NSInsertedObjectsKey]) changeType = BMFNotificationInsertedChangeType;
		
		NSSet *collection = [ui objectForKey:key];
		for (NSManagedObject *managedObject in collection) {
			for (NSManagedObjectID *objectId in objectIds) {
				if ([managedObject.objectID isEqual:objectId]) {
					resultDic[objectId] = @(changeType);
				}
			}
		}
	}
	
	return resultDic;
}

@end
