
#import "TRNParser.h"

#import <BMF/BMF.h>

#import "TRNBook.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation TRNParser {
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

- (NSArray *) extractIds:(NSArray *) dictionaries {
	NSMutableArray *ids = [NSMutableArray array];
	for (NSDictionary *dic in dictionaries) {
		if (dic[@"id"]) [ids addObject:dic[@"id"]];
	}
	
	[ids sortUsingSelector:@selector(compare:)];
		
	return ids;
}

- (NSComparisonResult) p_compareDictionaries:(NSDictionary *) obj1 with:(NSDictionary *)obj2 {
	NSNumber *id1 = obj1[@"id"];
	NSNumber *id2 = obj2[@"id"];
	
	return [id1 compare:id2];
}

- (void) p_updateEntity:(TRNBook *)entity withDictionary:(NSDictionary *) dic {
	entity.id = [dic[@"id"] integerValue];
	entity.title = dic[@"title"];
	entity.author = dic[@"author"];
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
	
		NSMutableArray *results = nil;
	
		results = [NSMutableArray array];
		
		NSArray *dictionaries = rawObject[@"books"];
		if (dictionaries.count>0) {
			
			NSUInteger batchSize = 100;
			
			[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
				NSError *error = nil;
				
				NSArray *sortedDictionaries = [dictionaries sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
					return [self p_compareDictionaries:obj1 with:obj2];
				}];
				
				NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TRNBook"];
				
				fetchRequest.includesPropertyValues = NO;
				fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]];
				fetchRequest.fetchBatchSize = batchSize;
				
				NSArray *allLocalEntities = [localContext executeFetchRequest:fetchRequest error:&error];
				
				NSUInteger index = 0;
				NSUInteger localIndex = 0;
				NSUInteger serverIndex = 0;

				while (localIndex<allLocalEntities.count && serverIndex<sortedDictionaries.count) {
					TRNBook *localEntity = allLocalEntities[localIndex];
//					NSInteger localId = localEntity.id;
					
					NSDictionary *serverEntityDic = sortedDictionaries[serverIndex];
					
					NSComparisonResult comparisonResult = [self p_compareDictionaries:@{ @"id" : @(localEntity.id) } with:serverEntityDic];
					
//					NSInteger serverId = [serverBookDic[@"id"] integerValue];
					
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
						
						[self p_updateEntity:entity withDictionary:serverEntityDic];
						
						[results addObject:entity];
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
					
					NSDictionary *serverBookDic = sortedDictionaries[serverIndex];
					
					// Add all these objects
					TRNBook *entity = [TRNBook MR_createInContext:localContext];

					[self p_updateEntity:entity withDictionary:serverBookDic];
					
					[results addObject:entity];

					serverIndex++;
				}
				
				
			} completion:^(BOOL success, NSError *error) {
				[self.progress stop:nil];
				
				if (completionBlock) completionBlock(results,nil);
			}];
		}

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
