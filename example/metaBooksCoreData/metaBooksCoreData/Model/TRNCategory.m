// Generated Automatically: Any changes will be overwritten

#import "TRNCategory.h"
#import "TRNCategoryObjectStore.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation TRNCategory

+ (id<BMFObjectDataStoreProtocol>) categoryDataStore {
	return [TRNCategoryObjectStore new];
}

+ (id<BMFDataReadProtocol>) allCategorysDataStore {
	NSFetchedResultsController *frc = [TRNCategory MR_fetchAllSortedBy:@"id" ascending:YES withPredicate:nil groupBy:nil delegate:nil];

	return [[BMFBase sharedInstance].factory dataStoreWithParameter:frc sender:self];
}

@end
