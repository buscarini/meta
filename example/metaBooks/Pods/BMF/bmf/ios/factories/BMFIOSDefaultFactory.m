//
//  BMFIOSDefaultFactory.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 31/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFIOSDefaultFactory.h"

/// Table view controllers
#import "BMFTableViewDataSource.h"
#import "BMFTableViewController.h"

/// Collection view controllers
#import "BMFCollectionViewDataSource.h"

/// Map view controllers
#import "BMFMapViewDataSource.h"
#import "BMFMapViewController.h"

/// Cell registers
#import "BMFCellRegisterProtocol.h"
#import "BMFSingleCellRegister.h"
#import "BMFSimpleViewRegister.h"
#import "BMFBlockCellRegister.h"

#import "BMFSimpleLoaderView.h"
#import "BMFHUDLoaderView.h"
#import "BMFLoaderBarItem.h"

//#import "BMFDataStoreFactory.h"

#import "BMFCellProtocol.h"


#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACDelegateProxy.h>

@implementation BMFIOSDefaultFactory

#pragma mark Loaders

- (UIView<BMFLoaderViewProtocol> *) generalLoaderView:(id) sender {
	return [BMFSimpleLoaderView new];
}

- (UIView<BMFLoaderViewProtocol> *) hudLoaderView:(id) sender {
	return [BMFHUDLoaderView new];
}

- (UIBarItem<BMFLoaderViewProtocol> *) navBarLoaderItem:(id) sender {
	return [BMFLoaderBarItem barItem];
}

#pragma mark Table

- (id) tableViewController:(id) sender {
	BMFTableViewController *vc = [BMFTableViewController new];
	
	RACDelegateProxy *tableViewDelegate = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UITableViewDelegate)];
	
	[[tableViewDelegate rac_signalForSelector:@selector(tableView:heightForRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] reduceEach:^(UITableView *tableView,NSIndexPath *indexPath){
		
		UITableViewCell<BMFCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
		
		cell.detailItem = [vc.dataSource itemAt:indexPath.section row:indexPath.row];
		
		cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
		
		[cell setNeedsLayout];
		[cell layoutIfNeeded];
		
		return @([cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+1.0f);
	}];
	
	return vc;
}

- (id) cellRegister:(NSString *) cellId classOrNib: (id) classOrNib sender:(id) sender {
	if (!cellId) cellId = @"cell";
	
	BMFSingleCellRegister *cellRegister = [[BMFSingleCellRegister alloc] initWithId:cellId classOrUINib:classOrNib];
	return cellRegister;
}

- (id) blockCellRegister:(BMFCellRegisterCellsBlock)registerBlock cellIdBlock:(BMFCellIdBlock) cellIdBlock sender:(id)sender {
	BMFBlockCellRegister *cellRegister = [[BMFBlockCellRegister alloc] initWithRegisterBlock:registerBlock dequeueBlock:cellIdBlock];
	return cellRegister;
}

- (id) viewRegister:(NSString *)viewId kind:(BMFViewKind)kind classOrNib:(id) classOrNib sender:(id) sender {
	
	BMFViewRegisterInfo *info = [[BMFViewRegisterInfo alloc] initWithId:viewId kind:kind classOrUINib:classOrNib];
	
	BMFSimpleViewRegister *viewRegister = [[BMFSimpleViewRegister alloc] initWithInfos:@[ info ]];
	return viewRegister;
	
}

- (id) tableViewDataSourceWithStore:(id<BMFDataReadProtocol>) store cellClassOrNib:(id) classOrNib animatedUpdates:(BOOL) animatedUpdates sender:(id) sender {

	BMFTableViewDataSource *dataSource = [[BMFTableViewDataSource alloc] initWithDataStore:store animatedUpdates:animatedUpdates];

	
	/*BMFTableViewDataSource *dataSource = [[BMFTableViewDataSource alloc] initWithDataStore:store configureCellBlock:^(id cell, id item) {
		id<BMFCellProtocol> tableCell = cell;
		tableCell.detailItem = item;
		
	} animatedUpdates:animatedUpdates];*/
	
	dataSource.cellRegister = [self cellRegister:@"cell" classOrNib:classOrNib sender:sender];
	
	return dataSource;
}


- (id) tableViewDataSourceWithStore:(id<BMFDataReadProtocol>) store cellClassOrNib:(id) classOrNib sender:(id) sender {
	return [self tableViewDataSourceWithStore:store cellClassOrNib:classOrNib animatedUpdates:NO sender:sender];
}

- (BMFTableViewController *) tableViewControllerWithDataStore:(id<BMFDataReadProtocol>) dataStore cellClassOrNib:(id) classOrNib sender:(id) sender {
	BMFTableViewController *vc = [self tableViewController:sender];
	vc.dataSource = [self tableViewDataSourceWithStore:dataStore cellClassOrNib:classOrNib sender:sender];
	return vc;
}

- (void) setupTableViewController:(BMFTableViewController *)vc withDataStore:(id<BMFDataReadProtocol>) dataStore cellClassOrNib:(id) classOrNib sender:(id) sender {
	vc.dataSource = [self tableViewDataSourceWithStore:dataStore cellClassOrNib:classOrNib sender:sender];
}

- (BMFTableViewController *) tableViewController:(id) classOrNib sender:(id) sender {
	return [self tableViewController:sender];
//	vc.dataSource = [self tableViewDataSourceWithStore:[self arrayDataStore:nil sender:sender] cellClassOrNib:classOrNib sender:sender];
}

- (id) tableViewControllerWithArray:(NSArray *) items cellClassOrNib:(id) classOrNib sender:(id) sender {
	
	BMFTableViewController *vc = [self tableViewController:classOrNib sender:sender];
	
	id<BMFDataReadProtocol> dataStore = [self dataStoreWithParameter:items sender:sender];
	
	vc.dataSource = [self tableViewDataSourceWithStore:dataStore cellClassOrNib:classOrNib sender:sender];
	
	return vc;
}

#pragma mark Collection view

- (id) collectionViewDataSourceWithStore:(id<BMFDataReadProtocol>) store cellRegister:(id<BMFCellRegisterProtocol>)cellRegister sender:(id) sender {
	BMFCollectionViewDataSource *dataSource = [[BMFCollectionViewDataSource alloc] initWithDataStore:store];
	
	if (cellRegister) dataSource.cellRegister = cellRegister;
	
	return dataSource;
}

- (id) collectionViewDataSourceWithStore:(id<BMFDataReadProtocol>) store cellClassOrNib:(id) classOrNib sender:(id) sender {
	id<BMFCellRegisterProtocol> cellRegister = nil;
	if (classOrNib) cellRegister = [self cellRegister:@"cell" classOrNib:classOrNib sender:sender];
	return [self collectionViewDataSourceWithStore:store cellRegister:cellRegister sender:sender];
}

- (id) collectionViewDataSourceWithStore:(id<BMFDataReadProtocol>) store cellRegisterBlock:(BMFCellRegisterCellsBlock) cellRegisterBlock cellIdBlock:(BMFCellIdBlock)cellIdBlock sender:(id) sender {
	
	id<BMFCellRegisterProtocol> cellRegister = nil;
	if (cellRegisterBlock) cellRegister = [self blockCellRegister:cellRegisterBlock cellIdBlock:cellIdBlock sender:sender];
	
	return [self collectionViewDataSourceWithStore:store cellRegister:cellRegister sender:sender];
}

#pragma mark Map view

- (id<BMFDataSourceProtocol>) mapViewDataSourceWithStore:(id<BMFDataReadProtocol>) store sender:(id)sender {
	return [[BMFMapViewDataSource alloc] initWithDataStore:store];
}


- (BMFMapViewController *) mapViewControllerWithStore:(id<BMFDataReadProtocol>) store sender:(id)sender {
	BMFMapViewController *vc  = [BMFMapViewController new];
	vc.dataSource = [self mapViewDataSourceWithStore:store sender:sender];
	return vc;
}


@end
