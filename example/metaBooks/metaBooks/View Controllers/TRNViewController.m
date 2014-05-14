//
//  TRNViewController.m
//  metaBooks
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/05/14.
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import "TRNViewController.h"


#import <ReactiveCocoa/RACEXTScope.h>

#import <BMF/BMFBase.h>
#import <BMF/BMFOperationsTask.h>
#import <BMF/BMFParserOperation.h>
#import <BMF/BMFArrayDataStore.h>
#import <BMF/BMFTableViewDataSource.h>
#import <BMF/BMFLoaderViewProtocol.h>

#import "TRNParser.h"

@interface TRNViewController ()

@end

@implementation TRNViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.loaderView = [[BMFBase sharedInstance].factory navBarLoaderItem:self];
	@weakify(self);
	self.loaderView.reloadActionBlock = ^(id sender) {
		@strongify(self);
		[self loadBooks];
	};

	[self.loaderView addToViewController:self];
		
	BMFArrayDataStore *dataStore = (id)[[BMFBase sharedInstance].factory dataStoreWithParameter:@[] sender:self];
	
	self.dataSource = [[BMFBase sharedInstance].factory tableViewDataSourceWithStore:dataStore cellClassOrNib:nil animatedUpdates:YES sender:self];
	
	self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		return [RACSignal defer:^RACSignal *{
			@strongify(self);
			[self loadBooks];
			
			return [RACSignal empty];
		}];
	}];
	
	[self loadBooks];
}

- (void) loadBooks {
	
	id<BMFTaskProtocol> task = [[BMFBase sharedInstance].factory jsonLoadTask:@"http://localhost:3000/books" parameters:nil parser:[TRNParser new] sender:self];
	
	[task start:^(id result, NSError *error) {
		
		BMFArrayDataStore *dataStore = (id)self.dataSource.dataStore;
		
		if (!error) dataStore.items = result;
		DDLogInfo(@"Finished loading");
	}];
}

@end
