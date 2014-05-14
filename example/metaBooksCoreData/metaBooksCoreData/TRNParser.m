
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
								
//				NSArray *serverIds = [self extractIds:dictionaries];
				
				NSArray *sortedDictionaries = [dictionaries sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
					NSNumber *id1 = obj1[@"id"];
					NSNumber *id2 = obj2[@"id"];

					return [id1 compare:id2];
				}];
				
				NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"TRNBook"];
				
				fetchRequest.includesPropertyValues = NO;
				fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey: @"id" ascending:YES]];
				fetchRequest.fetchBatchSize = batchSize;
				
				NSArray *allLocalEntities = [localContext executeFetchRequest:fetchRequest error:&error];
				
				NSUInteger index = 0;
				NSUInteger localIndex = 0;
				NSUInteger serverIndex = 0;

				while (localIndex<allLocalEntities.count) {
					while (serverIndex<sortedDictionaries.count) {
						TRNBook *localBook = allLocalEntities[localIndex];
						NSInteger localId = localBook.id;
						
						NSDictionary *serverBookDic = sortedDictionaries[serverIndex];
						
						NSInteger serverId = [serverBookDic[@"id"] integerValue];
						
						if (localId<serverId) {
							// Remove local object
							[localContext deleteObject:localBook];

							localIndex++;
						}
						else {
							
							TRNBook *book = localBook;
							
							if (localId>serverId) {
								// Add object
								book = [TRNBook MR_createInContext:localContext];
							}
							else {
								localIndex++;
							}
							
							serverIndex++;
							
							book.id = [serverBookDic[@"id"] integerValue];
							book.title = serverBookDic[@"title"];
							book.author = serverBookDic[@"author"];
							
							[results addObject:book];
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
				}
				
				if (localIndex<allLocalEntities.count) {
					// Delete all these objects
					while (localIndex<allLocalEntities.count) {
						TRNBook *localBook = allLocalEntities[localIndex];
						[localContext deleteObject:localBook];
						localIndex++;
					}
				}
				
				if (serverIndex<sortedDictionaries.count) {
					
					NSDictionary *serverBookDic = sortedDictionaries[serverIndex];
					
					// Add all these objects
					TRNBook *book = [TRNBook MR_createInContext:localContext];

					book.id = [serverBookDic[@"id"] integerValue];
					book.title = serverBookDic[@"title"];
					book.author = serverBookDic[@"author"];
					
					[results addObject:book];

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
