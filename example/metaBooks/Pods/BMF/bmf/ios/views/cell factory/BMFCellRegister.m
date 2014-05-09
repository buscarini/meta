//
//  TNCellRegister.m
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFCellRegister.h"

#import "BMF.h"

@implementation BMFCellRegister

- (NSString *) cellIdentifierForItem:(id)item atIndexPath:(NSIndexPath *) indexPath {
	return nil;
}

- (id) classOrUINibForIndexPath:(NSIndexPath *) indexPath {
	return nil;
}

- (void) registerCells:(UIView *) view {
	if (!view) return;
	
	if ([view isKindOfClass:[UITableView class]]) {
		[self registerTableCells:(UITableView *)view];
	}
	else if ([view isKindOfClass:[UICollectionView class]]) {
		[self registerCollectionCells:(UICollectionView *)view];
	}
	else {
		[NSException raise:@"View class not supported. Only supports tables and collections" format:@"%@",view];
	}
}

- (void) registerTableCells: (UITableView *) tableView {
	
}

- (void) registerCollectionCells:(UICollectionView *) collectionView {
	
}

@end
