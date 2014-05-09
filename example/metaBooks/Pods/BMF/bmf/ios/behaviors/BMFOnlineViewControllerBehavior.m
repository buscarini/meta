//
//  BMFOnlineViewControllerBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 03/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFOnlineViewControllerBehavior.h"

#import <AFNetworking/AFNetworking.h>

#import "BMFTableViewDataSource.h"

#import "BMFDataReadProtocol.h"

#import "BMFViewControllerDataSourceProtocol.h"

@interface BMFOnlineViewControllerBehavior()

@property (nonatomic, copy) BMFActionBlock actionBlock;

@end

@implementation BMFOnlineViewControllerBehavior {
	id reachabilityToken;
	id appActiveObserverToken;
}

- (instancetype) initWithActionBlock:(BMFActionBlock) actionBlock {
	BMFAssertReturnNil(actionBlock);
	
    self = [super init];
    if (self) {
		self.actionBlock = actionBlock;
    }
    return self;
}

- (instancetype)init {
	[NSException raise:@"Needs an action block." format:@"Use initWithActionBlock instead"];
    return nil;
}

- (id<BMFDataReadProtocol>) dataStore {
	
	if ([self.object conformsToProtocol:@protocol(BMFViewControllerDataSourceProtocol)]) {
		UIViewController<BMFViewControllerDataSourceProtocol> *dataSourceVC = (UIViewController<BMFViewControllerDataSourceProtocol> *)self.object;
		return dataSourceVC.dataSource;
	}
	

	return nil;
}

- (BOOL) dataLoaded {
	id<BMFDataReadProtocol> dataStore = [self dataStore];
	return dataStore.allItems.count>0;
}

#pragma View controller events

- (void) viewDidLoad {
	[self reloadData:YES];
}

- (void) viewWillAppear:(BOOL)animated {
	[self reloadData:NO];

	reachabilityToken = [[NSNotificationCenter defaultCenter] addObserverForName:AFNetworkingReachabilityDidChangeNotification object:self queue:nil usingBlock:^(NSNotification *note) {
		[self reloadData:NO];
	}];
	
	appActiveObserverToken = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:self queue:nil usingBlock:^(NSNotification *note) {
		[self reloadData:NO];
	}];
}

- (void) viewWillDisappear:(BOOL)animated {
	[self stopObserving];
}

- (void) dealloc {
	[self stopObserving];
}

- (void) stopObserving {
	[[NSNotificationCenter defaultCenter] removeObserver:reachabilityToken];
	[[NSNotificationCenter defaultCenter] removeObserver:appActiveObserverToken];
}

#pragma mark Actions

/// If force is NO we won't reload if we already have data
- (void) reloadData: (BOOL) force {
	if (!self.object) {
		DDLogInfo(@"Tried to reload, but no vc available");
		return;
	}
	
	if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==AFNetworkReachabilityStatusNotReachable) {
		DDLogInfo(@"Tried to reload, but no data connection available");
		return;
	}
	
	if (!force && [self dataLoaded]) {
		DDLogInfo(@"Not reloading, data already loaded");
		return;
	}
	
	if (self.actionBlock) self.actionBlock(self.object);
}


@end
