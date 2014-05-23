//
//  TRNViewController.m
//  metaBooks
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/05/14.
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import "TRNBookListViewController.h"

#import <BMF/BMFOperationsTask.h>
#import <BMF/BMFParserOperation.h>
#import <BMF/BMFArrayDataStore.h>
#import <BMF/BMFTableViewDataSource.h>

#import "TRNCategory.h"
#import "TRNBook.h"

#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface TRNBookListViewController ()

@end

@implementation TRNBookListViewController

- (void) performInit {
	[super performInit];
	
	self.objectStore = [BMFObjectDataStore new];
	@weakify(self);
	self.objectStore.objectChangedBlock = ^(BMFObjectDataStore *store) {
		@strongify(self);
		if (store.object) {
			TRNCategory *category = store.object;
			id<BMFDataReadProtocol> dataStore = [[BMFBase sharedInstance].factory dataStoreWithParameter:category.books.allObjects sender:self];
			self.dataSource = [[BMFBase sharedInstance].factory tableViewDataSourceWithStore:dataStore cellClassOrNib:nil animatedUpdates:YES sender:self];
		}
	};
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	
	
	
	//id<BMFDataReadProtocol> dataStore =	[TRNBook allBooksDataStore];
	
//	NSFetchedResultsController *frc = [TRNBook MR_fetchAllSortedBy:@"id" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
//	
//	id<BMFDataReadProtocol> dataStore = (id)[[BMFBase sharedInstance].factory dataStoreWithParameter:frc sender:self];
	
//	BMFArrayDataStore *dataStore = (id)[[BMFBase sharedInstance].factory dataStoreWithParameter:@[] sender:self];
	
//	self.dataSource = [[BMFBase sharedInstance].factory tableViewDataSourceWithStore:dataStore cellClassOrNib:nil animatedUpdates:YES sender:self];
//	
//	@weakify(self);
//	self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//		return [RACSignal defer:^RACSignal *{
//			@strongify(self);
//			[self loadBooks];
//			
//			return [RACSignal empty];
//		}];
//	}];
//	
//	[self loadBooks];
}

//- (void) loadBooks {
//	id<BMFTaskProtocol> task = [[BMFBase sharedInstance].factory dataLoadTask:@"http://localhost:3000/books" parameters:nil sender:self];
//	
//	[self.loaderView.progress addChild:task.progress];
//	
//	BMFOperationsTask *opTask = [BMFOperationsTask BMF_cast:task];
//	
//	[opTask addOperation:[[BMFBase sharedInstance].factory jsonSerializerOperation:self]];
//	
//	TRNDataParser *parser = [TRNDataParser new];
//	BMFOperation *parserOp = [[BMFParserOperation alloc] initWithParser:parser];
//	[opTask addOperation:parserOp];
//	
//	[opTask start:^(id result, NSError *error) {
//		
////		BMFArrayDataStore *dataStore = (id)self.dataSource.dataStore;
////		
////		if (!error) dataStore.items = result;
////		DDLogInfo(@"Finished loading");
//	}];
//}

@end
