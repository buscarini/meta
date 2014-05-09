//
//  BMFItemTapBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 20/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFItemTapBehavior.h"

#import "BMFDataSourceProtocol.h"
#import "BMFDataReadProtocol.h"

#import "BMF.h"

@implementation BMFItemTapBehavior

- (instancetype)init {
	self = [super init];
	if (self) {
		self.deselectItemOnTap = YES;
    }
	return self;
}

#pragma mark UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.deselectItemOnTap) [tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self tapInDataSource:(id<BMFDataSourceProtocol>)tableView.dataSource indexPath:indexPath];
}

#pragma mark UICollectionViewDelegate

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (self.deselectItemOnTap) [collectionView deselectItemAtIndexPath:indexPath animated:YES];
	[self tapInDataSource:(id<BMFDataSourceProtocol>)collectionView.dataSource indexPath:indexPath];
}

#pragma mark Item tap

- (void) tapInDataSource:(id<BMFDataSourceProtocol>) dataSource indexPath:(NSIndexPath *)indexPath {
	if ([dataSource conformsToProtocol:@protocol(BMFDataSourceProtocol)]) {
		id<BMFDataReadProtocol> dataStore = dataSource.dataStore;
		id item = [dataStore itemAt:indexPath];
		[self itemTapped:item];
	}
	else {
		[NSException raise:@"View data source should conform to protocol BMFDataSourceProtocol" format:@"%@",dataSource];
	}
}

- (void) itemTapped:(id) item {
	[NSException raise:@"Behavior subclass should implement itemTapped:" format:@"%@",self];
}

@end
