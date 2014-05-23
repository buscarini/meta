//
//  TRNCategoryListViewController.m
//  metaBooksCoreData
//
//  Created by Jose Manuel Sánchez Peñarroja on 23/05/14.
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import "TRNCategoryListViewController.h"

#import <BMF/BMFOperationsTask.h>
#import <BMF/BMFParserOperation.h>
#import <BMF/BMFArrayDataStore.h>
#import <BMF/BMFTableViewDataSource.h>

#import "TRNCategoriesServiceParser.h"

#import "TRNCategory.h"

#import <BMF/BMFPresentViewControllerBehavior.h>

#import <MagicalRecord/CoreData+MagicalRecord.h>


@interface TRNCategoryListViewController ()

@end

@implementation TRNCategoryListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.loaderView = [[BMFBase sharedInstance].factory navBarLoaderItem:self];
	//	self.loaderView = [[BMFBase sharedInstance].factory generalLoaderView:self];
	[self.loaderView addToViewController:self];
	
	
	id<BMFDataReadProtocol> dataStore =	[TRNCategory allCategorysDataStore];
		
	self.dataSource = [[BMFBase sharedInstance].factory tableViewDataSourceWithStore:dataStore cellClassOrNib:nil animatedUpdates:YES sender:self];

	@weakify(self);
	self.navigationItem.rightBarButtonItem.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		return [RACSignal defer:^RACSignal *{
			@strongify(self);
			[self load];
			
			return [RACSignal empty];
		}];
	}];
	
	[self load];
	
	BMFPresentViewControllerBehavior *itemBehavior = [BMFPresentViewControllerBehavior new];
	itemBehavior.segueIdentifier = @"books";
	[self addBehavior:itemBehavior];
}

- (void) load {
	id<BMFTaskProtocol> task = [[BMFBase sharedInstance].factory dataLoadTask:@"http://192.168.1.135:3000/categories" parameters:nil sender:self];
	
	[self.loaderView.progress addChild:task.progress];
	
	BMFOperationsTask *opTask = [BMFOperationsTask BMF_cast:task];
	
	[opTask addOperation:[[BMFBase sharedInstance].factory jsonSerializerOperation:self]];
	
	TRNCategoriesServiceParser *parser = [TRNCategoriesServiceParser new];
	BMFOperation *parserOp = [[BMFParserOperation alloc] initWithParser:parser];
	[opTask addOperation:parserOp];
	
	[opTask start:^(id result, NSError *error) {
	}];
}
@end