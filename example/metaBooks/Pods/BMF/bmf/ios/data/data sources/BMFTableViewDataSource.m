//
//  TNTableDataSource.m
//  DataSources
//
//  Created by José Manuel Sánchez on 21/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFTableViewDataSource.h"

#import "BMFViewConfigurator.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACExtScope.h>

@interface BMFTableViewDataSource()

@property (nonatomic, assign) BOOL animatedUpdates;

@property (nonatomic, strong) NSMutableArray *observationTokens;

@end

@implementation BMFTableViewDataSource

- (instancetype) initWithDataStore:(id<BMFDataReadProtocol>)dataStore animatedUpdates:(BOOL)animatedUpdates {
		
    self = [super initWithDataStore:dataStore];
    if (self) {
		self.animatedUpdates = animatedUpdates;
		
		self.observationTokens = [NSMutableArray array];
		
		@weakify(self);
		[RACObserve(self, viewRegister) subscribeNext:^(id x) {
			@strongify(self);
			[self registerViews];
		}];
		
		[RACObserve(self, cellRegister) subscribeNext:^(id x) {
			@strongify(self);
			[self registerCells];
		}];

    }
    return self;
}

- (void) observeDataChanges {
	[self stopObserving];
	
	if (self.animatedUpdates) {

		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataWillChangeNotification object:self.dataStore] subscribeNext:^(NSNotification *note) {
			[self.tableView beginUpdates];
		}]];
		
		
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataSectionInsertedNotification object:self.dataStore] subscribeNext:^(NSNotification *note) {
			NSDictionary *dic = [NSDictionary BMF_cast:note.userInfo];
			NSNumber *index = dic[@"index"];
			if (index) [self.tableView insertSections:[NSIndexSet indexSetWithIndex:index.integerValue] withRowAnimation:UITableViewRowAnimationAutomatic];
		}]];
		
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataSectionDeletedNotification object:self.dataStore] subscribeNext:^(NSNotification *note) {
			NSDictionary *dic = [NSDictionary BMF_cast:note.userInfo];
			NSNumber *index = dic[@"index"];
			if (index) [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:index.integerValue] withRowAnimation:UITableViewRowAnimationAutomatic];
		}]];
		
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataInsertedNotification object:self.dataStore] subscribeNext:^(NSNotification *note) {
			NSDictionary *dic = [NSDictionary BMF_cast:note.userInfo];
			NSIndexPath *indexPath = dic[@"indexPath"];
			if (indexPath) [self.tableView insertRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
		}]];
		
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataDeletedNotification object:self.dataStore] subscribeNext:^(NSNotification *note) {
			NSDictionary *dic = [NSDictionary BMF_cast:note.userInfo];
			NSIndexPath *indexPath = dic[@"indexPath"];
			if (indexPath) [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
		}]];
		
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataUpdatedNotification object:self.dataStore] subscribeNext:^(NSNotification *note) {
			NSDictionary *dic = [NSDictionary BMF_cast:note.userInfo];
			NSIndexPath *indexPath = dic[@"indexPath"];
			if (indexPath) [self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
		}]];
		
		[self.observationTokens addObject:[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataDidChangeNotification object:self.dataStore] subscribeNext:^(NSNotification *note) {
			@try {
				[self.tableView endUpdates];
			}
			@catch (NSException *exception) {
				DDLogError(@"Exception updating table: %@",exception);
				[self.tableView reloadData];
			}

		}]];
	}

	[self.observationTokens addObject:[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:BMFDataBatchChangeNotification object:self.dataStore] throttle:0.5] subscribeNext:^(id x) {
		[self.tableView reloadData];
	}]];
}

- (void) dealloc {
	self.dataStore = nil;
	
	[self stopObserving];
}

- (void) stopObserving {
	
	for (id token in self.observationTokens) {
		[token dispose];
	}
	
	[self.observationTokens removeAllObjects];
}

- (void) setDataStore:(id<BMFDataReadProtocol>)dataStore {
	[self stopObserving];
	
	[super setDataStore:dataStore];
	
	[self observeDataChanges];
}

- (void) setTableView:(UITableView *)tableView {
 	_tableView = tableView;
 	
	[self registerCells];
	[self registerViews];
}

- (void) registerCells {
	if (self.cellRegister) [self.cellRegister registerCells:self.tableView];
}

- (void) registerViews {
 	if (self.viewRegister) [self.viewRegister registerViews:self.tableView];
}

#pragma mark UITableViewDataSource

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [self titleForSection:section kind:BMFViewKindSectionHeader];
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	return [self titleForSection:section kind:BMFViewKindSectionFooter];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.dataStore numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dataStore numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *cellId = [self.cellRegister cellIdentifierForItem:[self.dataStore itemAt:indexPath.section row:indexPath.row] atIndexPath:indexPath];
		
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    id item = [self.dataStore itemAt:indexPath.section row:indexPath.row];
	
	
	Class<BMFViewConfiguratorProtocol> configurator = [BMFViewConfigurator configuratorForView:cell kind:BMFViewKindCell item:item inView:tableView];
	
	[configurator configure:cell kind:BMFViewKindCell withItem:item inView:tableView atIndexPath:indexPath controller:self.controller];
		
    return cell;
}

#pragma mark UITableViewDelegate

/*- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
	id item = [self.dataStore itemAt:indexPath.section row:indexPath.row];
	
//	NSString *cellId = [self.cellRegister cellIdentifierForItem:[self.dataStore itemAt:indexPath.section row:indexPath.row] atIndexPath:indexPath];
	
//	id cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
	
	id<BMFCellConfiguratorProtocol> configurator = [BMFCellConfigurator configuratorForCell:cell item:item inView:tableView];
	
	if ([configurator respondsToSelector:@selector(heightOf:with:inView:)]) {
		return [configurator heightOf:cell with:item inView:tableView];
	}
	
	return tableView.rowHeight;
}*/

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	id item = [self.dataStore itemAt:indexPath.section row:indexPath.row];
	
	NSString *cellId = [self.cellRegister cellIdentifierForItem:[self.dataStore itemAt:indexPath.section row:indexPath.row] atIndexPath:indexPath];

	id cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
	
	id<BMFViewConfiguratorProtocol> configurator = [BMFViewConfigurator configuratorForView:cell kind:BMFViewKindCell item:item inView:tableView];

	if ([configurator respondsToSelector:@selector(heightOf:kind:withItem:inView:atIndexPath:)]) {
		return [configurator heightOf:cell kind:BMFViewKindCell withItem:item inView:tableView atIndexPath:indexPath];
	}
	
	return tableView.rowHeight;
}

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//	id item = [self.dataStore itemAt:indexPath.section row:indexPath.row];
//		
//	
//
//}

- (UIView *) tableView:(UITableView *)tableView viewWithKind:(BMFViewKind)kind atIndexPath:(NSIndexPath *) indexPath {
	id item = [self.dataStore itemAt:indexPath];
	
	NSString *viewId = [self.viewRegister viewIdentifierForKind:kind indexPath:indexPath];
	
	id view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:viewId];
	
	Class<BMFViewConfiguratorProtocol> configurator = [BMFViewConfigurator configuratorForView:view kind:kind item:item inView:tableView];
	
	[configurator configure:view kind:kind withItem:item inView:tableView atIndexPath:indexPath controller:self.controller];
	
	return view;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];

	return [self tableView:tableView viewWithKind:BMFViewKindSectionHeader atIndexPath:indexPath];
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
	
	return [self tableView:tableView viewWithKind:BMFViewKindSectionFooter atIndexPath:indexPath];
}

- (CGFloat) tableView:(UITableView *)tableView heightForViewKind:(BMFViewKind)kind atIndexPath:(NSIndexPath *) indexPath {
	id item = nil;
	if (!self.isEmpty) {
		item = [self.dataStore itemAt:indexPath];
	}
	
	NSString *viewId = [self.viewRegister viewIdentifierForKind:kind indexPath:indexPath];
	
	id view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:viewId];
	
	id<BMFViewConfiguratorProtocol> configurator = [BMFViewConfigurator configuratorForView:view kind:kind item:item inView:tableView];
	
	if ([configurator respondsToSelector:@selector(heightOf:kind:withItem:inView:atIndexPath:)]) {
		return [configurator heightOf:view kind:kind withItem:item inView:tableView atIndexPath:indexPath];
	}
	
	return UITableViewAutomaticDimension;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
	
	return [self tableView:tableView heightForViewKind:BMFViewKindSectionHeader atIndexPath:indexPath];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
	
	return [self tableView:tableView heightForViewKind:BMFViewKindSectionFooter atIndexPath:indexPath];
}

@end
