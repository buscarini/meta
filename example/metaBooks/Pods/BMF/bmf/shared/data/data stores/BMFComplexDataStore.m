//
//  BMFComplexDataStore.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFComplexDataStore.h"

#import "BMFTypes.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACExtScope.h>

@interface BMFComplexDataStore()

@property (nonatomic, strong) NSMutableArray *observationTokens;

@end

@implementation BMFComplexDataStore

- (instancetype) initWithStores:(NSArray *) dataStores {
	BMFAssertReturnNil(dataStores);
	BMFAssertReturnNil(dataStores.count>0);
	
	self = [super init];
	if (self) {
		_dataStores = dataStores;
		_observationTokens = [NSMutableArray array];
		[self updateObservers];
	}
	return self;
}

- (instancetype) init {
	BMFInvalidInit(initWithStores:);
}

- (void) setDataStores:(NSArray *)dataStores {
	BMFAssertReturn(dataStores);
	BMFAssertReturn(dataStores.count>0);
	_dataStores = [NSArray arrayWithArray:dataStores];
	
	[self updateObservers];
}

- (void) dealloc {
	[self stopObserving];
}

- (void) updateObservers {
	[self stopObserving];

	@weakify(self);
	for (id _dataStore in self.dataStores) {
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataWillChangeNotification object:_dataStore] subscribeNext:^(NSNotification *note) {
			@strongify(self);
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataWillChangeNotification object:self userInfo:note.userInfo];
		}]];
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataSectionInsertedNotification object:_dataStore] subscribeNext:^(NSNotification *note) {
			@strongify(self);
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataSectionInsertedNotification object:self userInfo:note.userInfo];
		}]];
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataSectionDeletedNotification object:_dataStore] subscribeNext:^(NSNotification *note) {
			@strongify(self);
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataSectionDeletedNotification object:self userInfo:note.userInfo];
		}]];
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataInsertedNotification object:_dataStore] subscribeNext:^(NSNotification *note) {
			@strongify(self);
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataInsertedNotification object:self userInfo:note.userInfo];
		}]];
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataMovedNotification object:_dataStore] subscribeNext:^(NSNotification *note) {
			@strongify(self);
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataMovedNotification object:self userInfo:note.userInfo];
		}]];
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataUpdatedNotification object:_dataStore] subscribeNext:^(NSNotification *note) {
			@strongify(self);
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataUpdatedNotification object:self userInfo:note.userInfo];
		}]];
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataDeletedNotification object:_dataStore] subscribeNext:^(NSNotification *note) {
			@strongify(self);
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataDeletedNotification object:self userInfo:note.userInfo];
		}]];
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataDidChangeNotification object:_dataStore] subscribeNext:^(NSNotification *note) {
			@strongify(self);
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataDidChangeNotification object:self userInfo:note.userInfo];
		}]];
		[self.observationTokens addObject:[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataBatchChangeNotification object:_dataStore] deliverOn:[RACScheduler mainThreadScheduler] ] subscribeNext:^(NSNotification *note) {
			@strongify(self);
			[[NSNotificationCenter defaultCenter] postNotificationName:BMFDataBatchChangeNotification object:self userInfo:note.userInfo];
		}]];
	}
}

- (void) stopObserving {
	for (id token in self.observationTokens) {
		[token dispose];
	}
	
	[self.observationTokens removeAllObjects];
}

#pragma mark BMFDataReadProtocol

- (NSInteger) numberOfSections { return 0; }
- (NSInteger) numberOfRowsInSection:(NSUInteger) section { return 0; }
- (NSString *) titleForSection:(NSUInteger) section kind:(BMFViewKind)kind { return nil; }
- (id) itemAt:(NSInteger) section row:(NSInteger) row { return nil; }
- (id) itemAt:(NSIndexPath *) indexPath  { return nil; }

- (NSIndexPath *) indexOfItem:(id) item { return nil; }

- (NSArray *) allItems { return nil; }

- (BOOL) isEmpty {
	NSMutableArray *results = [NSMutableArray array];
	for (id<BMFDataReadProtocol> dataStore in self.dataStores) {
		if (![dataStore isEmpty]) return NO;
	}
	
	return YES;
}

@end
