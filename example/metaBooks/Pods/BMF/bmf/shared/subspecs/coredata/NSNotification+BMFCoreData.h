//
//  NSNotification+BMFCoreData.h
//  ExampleMac
//
//  Created by Jose Manuel Sánchez Peñarroja on 16/04/14.
//  Copyright (c) 2014 josé manuel sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BMFNotificationChangeType) {
	BMFNotificationDeletedChangeType,
	BMFNotificationUpdatedChangeType,
	BMFNotificationInsertedChangeType
};

@interface NSNotification (BMFCoreData)

/// Valid for NSManagedObjectContextDidSaveNotification. Takes an array of object ids and returns a dictionary with objectids as keys and nsnumber containing a BMFNotificationChangeType
- (NSDictionary *) BMF_changesInObjectIDs:(NSArray *) objectIds;

@end
