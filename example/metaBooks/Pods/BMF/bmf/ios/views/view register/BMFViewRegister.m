//
//  BMFViewRegister.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewRegister.h"

@implementation BMFViewRegister

- (NSString *) viewIdentifierForKind:(BMFViewKind) kind indexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (id) classOrUINibForKind:(BMFViewKind) kind IndexPath:(NSIndexPath *) indexPath {
	return nil;
}

- (void) registerViews:(UIView *)view {
	if (!view) return;
	
	if ([view isKindOfClass:[UITableView class]]) {
		[self registerTableViews:(UITableView *)view];
	}
	else if ([view isKindOfClass:[UICollectionView class]]) {
		[self registerCollectionViews:(UICollectionView *)view];
	}
	else {
		[NSException raise:@"View class not supported. Only supports tables and collections" format:@"%@",view];
	}
}

- (void) registerTableViews: (UITableView *) tableView {
	
}

- (void) registerCollectionViews:(UICollectionView *) collectionView {
	
}

@end
