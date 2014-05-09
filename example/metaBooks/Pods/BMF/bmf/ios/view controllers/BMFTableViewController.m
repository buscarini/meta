//
//  TRNTableViewController.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/12/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFTableViewController.h"

#import "BMFTableViewDataSource.h"

#import "UITableView+BMF.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface BMFTableViewController () <UITableViewDelegate>

@end

@implementation BMFTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	@weakify(self);
	[[RACObserve(self, dataSource) scanWithStart:nil reduce:^id(id running, id next) {
		@strongify(self);
		[self removeBehavior:running];
		return next;
	}] subscribeNext:^(id x) {
		@strongify(self);
		self.tableView.dataSource = x;
		if (x) [self addBehavior:x];
		self.dataSource.tableView = self.tableView;
		self.dataSource.controller = self.BMF_proxy;
		[self.tableView reloadData];
	}];
	
	[self.BMF_proxy.destinationsSignal subscribeNext:^(id x) {
		@strongify(self);
		[self.tableView BMF_updateDelegate:self.BMF_proxy];
	}];
		
	self.hidesSeparatorsForEmptyCells = YES;
	
	if (self.didLoadBlock) self.didLoadBlock(self);
}

#pragma mark Accessors

- (void) setHidesSeparatorsForEmptyCells:(BOOL)hidesSeparatorsForEmptyCells {
	_hidesSeparatorsForEmptyCells = hidesSeparatorsForEmptyCells;
	
	if ([self isViewLoaded]) [self hidesSeparatorsForEmptyCells];
}

- (void) hideSeparatorsForEmptyCells {
	if (self.hidesSeparatorsForEmptyCells) {
		UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
		self.tableView.tableFooterView = footer;
	}
	else {
		self.tableView.tableFooterView = nil;
	}
}

@end
