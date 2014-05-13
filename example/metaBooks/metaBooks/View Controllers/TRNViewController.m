//
//  TRNViewController.m
//  metaBooks
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/05/14.
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import "TRNViewController.h"

#import <BMF/BMFOperationsTask.h>
#import <BMF/BMFParserOperation.h>
#import <BMF/BMFArrayDataStore.h>
#import <BMF/BMFTableViewDataSource.h>

#import "TRNParser.h"

@interface TRNViewController ()

@end

@implementation TRNViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.loaderView = [[BMFBase sharedInstance].factory navBarLoaderItem:self];
//	self.loaderView = [[BMFBase sharedInstance].factory generalLoaderView:self];
	[self.loaderView addToViewController:self];
		
	BMFArrayDataStore *dataStore = (id)[[BMFBase sharedInstance].factory dataStoreWithParameter:@[] sender:self];
	
	self.dataSource = [[BMFBase sharedInstance].factory tableViewDataSourceWithStore:dataStore cellClassOrNib:nil animatedUpdates:YES sender:self];
	
	@weakify(self);
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
	id<BMFTaskProtocol> task = [[BMFBase sharedInstance].factory dataLoadTask:@"http://localhost:3000/books" parameters:nil sender:self];
	
	[self.loaderView.progress addChild:task.progress];
	
	BMFOperationsTask *opTask = [BMFOperationsTask BMF_cast:task];
	
	[opTask addOperation:[[BMFBase sharedInstance].factory jsonSerializerOperation:self]];
	
	TRNParser *parser = [TRNParser new];
	BMFOperation *parserOp = [[BMFParserOperation alloc] initWithParser:parser];
	[opTask addOperation:parserOp];
	
	[opTask start:^(id result, NSError *error) {
		
		BMFArrayDataStore *dataStore = (id)self.dataSource.dataStore;
		
		if (!error) dataStore.items = result;
		DDLogInfo(@"Finished loading");
	}];
}

@end
