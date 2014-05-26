//
//  BMFCompareParserStrategy.m
//  metaBooksCoreData
//
//  Created by Jose Manuel Sánchez Peñarroja on 26/05/14.
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import "BMFCompareParserStrategy.h"

#import <BMF/BMF.h>

@implementation BMFCompareParserStrategy

- (NSArray *) parseDictionaries:(NSArray *) dictionaries localObjects:(NSArray *) localObjects objectParser:(id<BMFObjectParserProtocol>) objectParser {
	
	NSMutableArray *results = [NSMutableArray array];
	
	localObjects = [localObjects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [objectParser compareObject:obj1 withObject:obj2];
	}];
	
	NSArray *sortedDictionaries = [dictionaries sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
		return [objectParser compareDictionary:obj1 withDictionary:obj2];
	}];
	
	NSUInteger index = 0;
	NSUInteger localIndex = 0;
	NSUInteger serverIndex = 0;
	
	NSError *error = nil;
	
	while (localIndex<localObjects.count && serverIndex<sortedDictionaries.count) {
		id localEntity = localObjects[localIndex];
		
		NSDictionary *serverEntityDic = sortedDictionaries[serverIndex];
		
		NSComparisonResult comparisonResult = [objectParser compareObject:localEntity withDictionary:serverEntityDic];
		
		if (comparisonResult==NSOrderedAscending) {
			[objectParser deleteObject:localEntity];
			
			localIndex++;
		}
		else {
			
			id entity = localEntity;
			
			if (comparisonResult==NSOrderedDescending) {
				// Add object
				entity = nil;
			}
			else {
				localIndex++;
			}
			
			serverIndex++;
			
			
			if (!entity) entity = [objectParser newObject];
			
			BOOL result = [objectParser updateObject:entity withDictionary:serverEntityDic error:&error];
			if (!result) {
				entity = nil;
				DDLogError(@"Error updating object: %@",error);
			}
			
			if (entity) {
				[results addObject:entity];
			}
			else {
				DDLogError(@"Error updating entity: %@",error);
			}
		}
		
		index++;
		
		if (index%self.batchSize==0) {
			[objectParser saveChanges];
		}
	}
	
	// Delete all these objects
	while (localIndex<localObjects.count) {
		id localEntity = localObjects[localIndex];
		[objectParser deleteObject:localEntity];
		localIndex++;
	}
	
	// Add all these objects
	while (serverIndex<sortedDictionaries.count) {
		
		NSDictionary *serverEntityDic = sortedDictionaries[serverIndex];
		
		id entity = [objectParser newObject];
		BOOL result = [objectParser updateObject:entity withDictionary:serverEntityDic error:&error];
		if (!result) {
			entity = nil;
			DDLogError(@"Error updating object: %@",error);
		}
		else {
			[results addObject:entity];
		}
		serverIndex++;
	}
	
	return results;
}

@end
