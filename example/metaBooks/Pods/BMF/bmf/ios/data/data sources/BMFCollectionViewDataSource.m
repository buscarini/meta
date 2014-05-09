//
//  TNCollectionViewDataSource.m
//  DataSources
//
//  Created by José Manuel Sánchez on 21/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFCollectionViewDataSource.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "BMFViewConfigurator.h"

#import "UICollectionView+BMF.h"

@implementation BMFCollectionViewDataSource {
	id dataDidChangeObservationToken;
	id dataBatchChangeObservationToken;
}

- (void) dealloc {
	[self stopObserving];
}


- (void) setDataStore:(id<BMFDataReadProtocol>)dataStore {
	[self stopObserving];
	
	[super setDataStore:dataStore];

	[self observeDataChanges];
	
	[self.collectionView reloadData];
}

- (void) setCollectionView:(UICollectionView *)collectionView {
	_collectionView = collectionView;
	_collectionView.dataSource = self;
	
	[self registerCells];
 	[self registerViews];
	
	[_collectionView reloadData];
}

- (void) registerCells {
	if (self.cellRegister) [self.cellRegister registerCells:self.collectionView];
}

- (void) registerViews {
 	if (self.supplementaryViewRegister) [self.supplementaryViewRegister registerViews:self.collectionView];
}

#pragma mark Observe data changes

- (void) observeDataChanges {
	if (dataDidChangeObservationToken) [[NSNotificationCenter defaultCenter] removeObserver:dataDidChangeObservationToken];
	dataDidChangeObservationToken = [[NSNotificationCenter defaultCenter] addObserverForName:BMFDataDidChangeNotification object:self.dataStore queue:nil usingBlock:^(NSNotification *note) {
		[self.collectionView reloadData];
		if (self.dataChangedBlock) self.dataChangedBlock(self.dataStore,nil);
	}];
	
	if (dataBatchChangeObservationToken) [[NSNotificationCenter defaultCenter] removeObserver:dataBatchChangeObservationToken];
	dataBatchChangeObservationToken = [[NSNotificationCenter defaultCenter] addObserverForName:BMFDataBatchChangeNotification object:self.dataStore queue:nil usingBlock:^(NSNotification *note) {
		[self.collectionView reloadData];
		if (self.dataChangedBlock) self.dataChangedBlock(self.dataStore,nil);
	}];
}

- (void) stopObserving {
	if (dataDidChangeObservationToken) [[NSNotificationCenter defaultCenter] removeObserver:dataDidChangeObservationToken];
	if (dataBatchChangeObservationToken) [[NSNotificationCenter defaultCenter] removeObserver:dataBatchChangeObservationToken];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return [self.dataStore numberOfSections];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.dataStore numberOfRowsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

	id item = [self.dataStore itemAt:indexPath];
	
	NSString *cellId = [self.cellRegister cellIdentifierForItem:item atIndexPath:indexPath];
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

	Class<BMFViewConfiguratorProtocol> configurator = [BMFViewConfigurator configuratorForView:cell kind:BMFViewKindCell item:item inView:collectionView];
	
	[configurator configure:cell kind:BMFViewKindCell withItem:item inView:collectionView atIndexPath:indexPath controller:self.controller];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kindString atIndexPath:(NSIndexPath *)indexPath {

	BMFViewKind kind = [UICollectionView BMF_kindFromKindString:kindString];
		
	NSString *viewId = [self.supplementaryViewRegister viewIdentifierForKind:kind indexPath:indexPath];
 		
 	UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kindString withReuseIdentifier:viewId forIndexPath:indexPath];
 	
	id item = [self.dataStore itemAt:indexPath];

	Class<BMFViewConfiguratorProtocol> configurator = [BMFViewConfigurator configuratorForView:view kind:kind item:item inView:collectionView];

	[configurator configure:view kind:kind withItem:item inView:collectionView atIndexPath:indexPath controller:self.controller];

	return view;
}

@end
