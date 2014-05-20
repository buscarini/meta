// Generated Automatically: Any changes will be overwritten

#import "TRNBook.h"
#import "TRNBookObjectStore.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation TRNBook

+ (id<BMFObjectDataStoreProtocol>) bookDataStore {
	return [TRNBookObjectStore new];
}

+ (id<BMFDataReadProtocol>) allBooksDataStore {
	NSFetchedResultsController *frc = [TRNBook MR_fetchAllSortedBy:@"id" ascending:YES withPredicate:nil groupBy:nil delegate:nil];

	return [[BMFBase sharedInstance].factory dataStoreWithParameter:frc sender:self];
}

@end
