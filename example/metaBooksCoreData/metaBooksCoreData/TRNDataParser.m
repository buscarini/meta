
#import "TRNDataParser.h"

#import <BMF/BMF.h>

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "TRNCategory.h"
#import "TRNBook.h"
	
@implementation TRNDataParser {
	NSDateFormatter *purchaseDateDateFormatter;
}

- (id) init {
	self = [super init];
	if (self) {
		purchaseDateDateFormatter = [[NSDateFormatter alloc] init];
		purchaseDateDateFormatter.dateFormat = @"dd.MM.yyyy";
	}
	return self;
}

- (NSComparisonResult) p_compareCategoryDictionaries:(NSDictionary *) obj1 with:(NSDictionary *)obj2 {
	NSComparisonResult result;
	id id1 = obj1[@"id"];
	id id2 = obj2[@"id"];
	result = [id1 compare:id2];
	if (result!=NSOrderedSame) return result;

	return NSOrderedSame;
}
- (NSComparisonResult) p_compareBookDictionaries:(NSDictionary *) obj1 with:(NSDictionary *)obj2 {
	NSComparisonResult result;
	id id1 = obj1[@"id"];
	id id2 = obj2[@"id"];
	result = [id1 compare:id2];
	if (result!=NSOrderedSame) return result;

	return NSOrderedSame;
}

- (BOOL) p_updateCategoryEntity:(TRNCategory *)object withDictionary:(NSDictionary *) dic error:(NSError **) error {
	id value;
	value = dic[@"id"];
	if ([value isKindOfClass:[NSNumber class]]) {
		object.id = [value integerValue];
	}
	else {
		// If required stop parsing
		*error = [NSError errorWithDomain:@"Parse" code:BMFErrorInvalidType userInfo:@{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Invalid type or missing key: %@ for property id",value] }];
		return NO;
	}

	value = dic[@"title"];
	if ([value isKindOfClass:[NSString class]]) {
		object.title = value;
	}
	else {
		DDLogWarn(@"Invalid type or missing key for property title: %@",value);
	}
	
	return YES;
}
- (BOOL) p_updateBookEntity:(TRNBook *)object withDictionary:(NSDictionary *) dic error:(NSError **) error {
	id value;
	value = dic[@"id"];
	if ([value isKindOfClass:[NSNumber class]]) {
		object.id = [value integerValue];
	}
	else {
		// If required stop parsing
		*error = [NSError errorWithDomain:@"Parse" code:BMFErrorInvalidType userInfo:@{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Invalid type or missing key: %@ for property id",value] }];
		return NO;
	}

	value = dic[@"title"];
	if ([value isKindOfClass:[NSString class]]) {
		object.title = value;
	}
	else {
		DDLogWarn(@"Invalid type or missing key for property title: %@",value);
	}
	value = dic[@"author"];
	if ([value isKindOfClass:[NSString class]]) {
		object.author = value;
	}
	else {
		DDLogWarn(@"Invalid type or missing key for property author: %@",value);
	}
	value = dic[@"numPages"];
	if ([value isKindOfClass:[NSNumber class]]) {
		object.numPages = [value integerValue];
	}
	else {
		DDLogWarn(@"Invalid type or missing key for property numPages: %@",value);
	}

	value = dic[@"purchaseDate"];
	if ([value isKindOfClass:[NSString class]]) {
		object.purchaseDate = [purchaseDateDateFormatter dateFromString:value];
	}
	else {
		DDLogWarn(@"Invalid type or missing key for property purchaseDate: %@",value);
	}

	
	return YES;
}

- (void) parse:(NSDictionary *) rawObject completion:(BMFCompletionBlock) completionBlock {
	
	[self.progress start];
	
	@try {
		
		/// Check result
		id result = rawObject[@"result"];
		if (![result isEqual:@"0"]) {
			NSString *errorMessage = rawObject[@"errorMessage"];
			if (!errorMessage) {
				errorMessage = BMFLocalized(@"Unknown error",nil);
			}
		    NSError *error = [NSError errorWithDomain:@"Parse" code:BMFErrorData userInfo:@{ NSLocalizedDescriptionKey : errorMessage }];
			[self.progress stop:error];
			if (completionBlock) completionBlock(nil,error);
			return;
		}
	
		NSMutableArray *results = [NSMutableArray array];
		NSArray *dictionaries = nil;
		
		dictionaries = rawObject[@"categories"];
		if (dictionaries.count>0) {
			
			NSUInteger batchSize = 100;
			
			[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
				NSError *error = nil;

				NSArray *sortedDictionaries = [dictionaries sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
					return [self p_compareCategoryDictionaries:obj1 with:obj2];
				}];

				NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TRNCategory"];

				fetchRequest.includesPropertyValues = NO;
				fetchRequest.sortDescriptors = @[
					[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES],
						];
				fetchRequest.fetchBatchSize = batchSize;

				NSArray *allLocalEntities = [localContext executeFetchRequest:fetchRequest error:&error];

				NSUInteger index = 0;
				NSUInteger localIndex = 0;
				NSUInteger serverIndex = 0;

				while (localIndex<allLocalEntities.count && serverIndex<sortedDictionaries.count) {
					TRNCategory *localEntity = allLocalEntities[localIndex];
	
					NSDictionary *serverEntityDic = sortedDictionaries[serverIndex];
	
					NSComparisonResult comparisonResult = [self p_compareCategoryDictionaries:@{
						@"id" : @(localEntity.id)

						} with:serverEntityDic];
		
					if (comparisonResult==NSOrderedAscending) {
						// Remove local object
						[localContext deleteObject:localEntity];

						localIndex++;
					}
					else {
		
						TRNCategory *entity = localEntity;
		
						if (comparisonResult==NSOrderedDescending) {
							// Add object
							entity = [TRNCategory MR_createInContext:localContext];
						}
						else {
							localIndex++;
						}
		
						serverIndex++;
		
						if ([self p_updateCategoryEntity:entity withDictionary:serverEntityDic error:&error]) {
							[results addObject:entity];	
						}
						else {
							DDLogError(@"Error updating entity: %@",error);
						}
					}
	
					index++;
	
					if (index%batchSize==0) {
						[localContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *saveError) {
							if (saveError) {
								DDLogError(@"Error saving sync context: %@",saveError);
							}
							else {
								DDLogInfo(@"Sync context saved");
							}
						}];
					}
				}

				// Delete all these objects
				while (localIndex<allLocalEntities.count) {
					TRNCategory *localEntity = allLocalEntities[localIndex];
					[localContext deleteObject:localEntity];
					localIndex++;
				}

				// Add all these objects
				while (serverIndex<sortedDictionaries.count) {
	
					NSDictionary *serverEntityDic = sortedDictionaries[serverIndex];
	
					// Add all these objects
					TRNCategory *entity = [TRNCategory MR_createInContext:localContext];

					if ([self p_updateCategoryEntity:entity withDictionary:serverEntityDic error:&error]) {
						[results addObject:entity];						
					}
					else {
						DDLogError(@"Error updating entity: %@",error);
					}

					serverIndex++;
				}


			} completion:^(BOOL success, NSError *error) {
				[self.progress stop:nil];

				if (completionBlock) completionBlock(results,nil);
			}];
		
		}
		
		dictionaries = rawObject[@"books"];
		if (dictionaries.count>0) {
			
			NSUInteger batchSize = 100;
			
			[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
				NSError *error = nil;

				NSArray *sortedDictionaries = [dictionaries sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
					return [self p_compareBookDictionaries:obj1 with:obj2];
				}];

				NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TRNBook"];

				fetchRequest.includesPropertyValues = NO;
				fetchRequest.sortDescriptors = @[
					[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES],
						];
				fetchRequest.fetchBatchSize = batchSize;

				NSArray *allLocalEntities = [localContext executeFetchRequest:fetchRequest error:&error];

				NSUInteger index = 0;
				NSUInteger localIndex = 0;
				NSUInteger serverIndex = 0;

				while (localIndex<allLocalEntities.count && serverIndex<sortedDictionaries.count) {
					TRNBook *localEntity = allLocalEntities[localIndex];
	
					NSDictionary *serverEntityDic = sortedDictionaries[serverIndex];
	
					NSComparisonResult comparisonResult = [self p_compareBookDictionaries:@{
						@"id" : @(localEntity.id)

						} with:serverEntityDic];
		
					if (comparisonResult==NSOrderedAscending) {
						// Remove local object
						[localContext deleteObject:localEntity];

						localIndex++;
					}
					else {
		
						TRNBook *entity = localEntity;
		
						if (comparisonResult==NSOrderedDescending) {
							// Add object
							entity = [TRNBook MR_createInContext:localContext];
						}
						else {
							localIndex++;
						}
		
						serverIndex++;
		
						if ([self p_updateBookEntity:entity withDictionary:serverEntityDic error:&error]) {
							[results addObject:entity];	
						}
						else {
							DDLogError(@"Error updating entity: %@",error);
						}
					}
	
					index++;
	
					if (index%batchSize==0) {
						[localContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *saveError) {
							if (saveError) {
								DDLogError(@"Error saving sync context: %@",saveError);
							}
							else {
								DDLogInfo(@"Sync context saved");
							}
						}];
					}
				}

				// Delete all these objects
				while (localIndex<allLocalEntities.count) {
					TRNBook *localEntity = allLocalEntities[localIndex];
					[localContext deleteObject:localEntity];
					localIndex++;
				}

				// Add all these objects
				while (serverIndex<sortedDictionaries.count) {
	
					NSDictionary *serverEntityDic = sortedDictionaries[serverIndex];
	
					// Add all these objects
					TRNBook *entity = [TRNBook MR_createInContext:localContext];

					if ([self p_updateBookEntity:entity withDictionary:serverEntityDic error:&error]) {
						[results addObject:entity];						
					}
					else {
						DDLogError(@"Error updating entity: %@",error);
					}

					serverIndex++;
				}


			} completion:^(BOOL success, NSError *error) {
				[self.progress stop:nil];

				if (completionBlock) completionBlock(results,nil);
			}];
		
		}

		[self.progress stop:nil];

		if (completionBlock) completionBlock(results,nil);
	}
	@catch (NSException *exception) {
		DDLogError(@"Exception in parse: %@",exception);
	}
}

- (void) cancel {
    NSError *error = [NSError errorWithDomain:@"Parse" code:BMFErrorCancelled userInfo:@{ NSLocalizedDescriptionKey : BMFLocalized(@"Parse Operation Cancelled",nil) }];
	[self.progress stop:error];
}

@end
