
#import "TRNCategoriesServiceParser.h"

#import <BMF/BMF.h>
#import <BMF/BMFObjectParserProtocol.h>

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "TRNCategory.h"
#import "TRNBook.h"
#import "TRNCategoryParser.h"
#import "TRNBookParser.h"
	
@implementation TRNCategoriesServiceParser

- (id) parseDictionary:(NSDictionary *)dic class:(Class)entityClass entity:(id) entity context:(NSManagedObjectContext *) context parser:(id<BMFObjectParserProtocol>) parser {
	
	if (!entity) {
		entity = [entityClass MR_createInContext:context];
	}
	
	NSError *error = nil;
	BOOL result = [parser updateObject:entity withDictionary:dic error:&error];
	if (!result) {
		DDLogError(@"Error parsing object: %@",error);
		return nil;
	}
	
	return entity;
}

- (void) parse:(NSDictionary *) rawObject completion:(BMFCompletionBlock) completionBlock {
	
	TRNCategoryParser *TRNCategoryParserInstance = [TRNCategoryParser new];
	TRNBookParser *TRNBookParserInstance = [TRNBookParser new];
	
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
					return [TRNCategoryParserInstance compareDictionary:obj1 withDictionary:obj2];
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
	
					NSComparisonResult comparisonResult = [TRNCategoryParserInstance compareDictionary:@{
						@"id" : @(localEntity.id)

						} withDictionary:serverEntityDic];
		
					if (comparisonResult==NSOrderedAscending) {
						// Remove local object
						[localContext deleteObject:localEntity];

						localIndex++;
					}
					else {
		
						TRNCategory *entity = localEntity;
		
						if (comparisonResult==NSOrderedDescending) {
							// Add object
							entity = nil;
						}
						else {
							localIndex++;
						}
		
						serverIndex++;

		
						entity = [self parseDictionary:serverEntityDic class:[TRNCategory class] entity:entity context:localContext parser:TRNCategoryParserInstance];
						if (entity) {
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
					TRNCategory *entity = [self parseDictionary:serverEntityDic class:[TRNCategory class] entity:nil context:localContext parser:TRNCategoryParserInstance];

					if (entity) {
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
