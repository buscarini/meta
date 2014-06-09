// Generated Automatically: Any changes will be overwritten

#import "TRNCover.h"
#import "TRNCoverObjectStore.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation TRNCover

+ (id<BMFObjectDataStoreProtocol>) coverDataStore {
	return [TRNCoverObjectStore new];
}

+ (id<BMFDataReadProtocol>) allCoversDataStore {
	NSFetchedResultsController *frc = [TRNCover MR_fetchAllSortedBy:@"id" ascending:YES withPredicate:nil groupBy:nil delegate:nil];

	return [[BMFBase sharedInstance].factory dataStoreWithParameter:frc sender:self];
}

@end
