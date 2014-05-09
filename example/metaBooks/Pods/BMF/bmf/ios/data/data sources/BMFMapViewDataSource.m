//
//  TNMapDataStore.m
//  DataSources
//
//  Created by José Manuel Sánchez on 28/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFMapViewDataSource.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation BMFMapViewDataSource {
	id dataDidChangeObservationToken;
	id dataBatchChangeObservationToken;
}

- (instancetype) initWithDataStore:(id<BMFDataReadProtocol>) dataStore {
	
	if (!dataStore) return nil;
	
    self = [super init];
    if (self) {
        _dataStore = dataStore;
		[self loadItems];
		
		[self observeDataChanges];
		
		__weak BMFMapViewDataSource *wself =self;

		[RACObserve(self, dataStore) subscribeNext:^(id x) {
			[wself loadItems];
		}];

		[RACObserve(self, overlaysDataStore) subscribeNext:^(id x) {
			[wself loadItems];
		}];
    }
    return self;
}

- (id)init {
	return nil;
}

- (void) dealloc {
	if (dataDidChangeObservationToken) [[NSNotificationCenter defaultCenter] removeObserver:dataDidChangeObservationToken];
	if (dataBatchChangeObservationToken) [[NSNotificationCenter defaultCenter] removeObserver:dataBatchChangeObservationToken];
}

- (void) setMapView:(MKMapView *)mapView {
	_mapView = mapView;
	[self loadItems];
}

- (void) observeDataChanges {
	if (dataDidChangeObservationToken) [[NSNotificationCenter defaultCenter] removeObserver:dataDidChangeObservationToken];
	dataDidChangeObservationToken = [[NSNotificationCenter defaultCenter] addObserverForName:BMFDataDidChangeNotification object:_dataStore queue:nil usingBlock:^(NSNotification *note) {
		[self loadItems];
		if (self.dataChangedBlock) self.dataChangedBlock(_dataStore,nil);
	}];

	if (dataBatchChangeObservationToken) [[NSNotificationCenter defaultCenter] removeObserver:dataBatchChangeObservationToken];
	dataBatchChangeObservationToken = [[NSNotificationCenter defaultCenter] addObserverForName:BMFDataBatchChangeNotification object:_dataStore queue:nil usingBlock:^(NSNotification *note) {
		[self loadItems];
		if (self.dataChangedBlock) self.dataChangedBlock(_dataStore,nil);
	}];
}

- (void) setDataStore:(id<BMFDataReadProtocol>)dataStore {
	_dataStore = dataStore;
	[self observeDataChanges];
}

- (void) loadItems {
	
	if ([self.dataStore.allItems count]==0) return;
	
	[self.mapView removeAnnotations:self.mapView.annotations];
	[self.mapView removeOverlays:self.mapView.overlays];
		
	[self.mapView addAnnotations:[self.dataStore allItems]];
	[self.mapView addOverlays:[self.overlaysDataStore allItems]];
	
	if (self.dataChangedBlock) self.dataChangedBlock(self.dataStore.allItems,nil);
}

#pragma mark BMFDataReadProtocol

- (NSInteger) numberOfSections {
	return [self.dataStore numberOfSections];
}

- (NSInteger) numberOfRowsInSection:(NSUInteger) section {
	return [self.dataStore numberOfRowsInSection:section];
}

- (id) itemAt:(NSInteger) section row:(NSInteger) row {
	return [self.dataStore itemAt:section row:row];
}

- (NSArray *) allItems {
	return [self.dataStore allItems];
}


@end
