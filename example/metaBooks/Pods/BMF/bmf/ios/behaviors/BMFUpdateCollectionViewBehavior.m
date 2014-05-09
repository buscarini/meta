//
//  BMFUpdateCollectionViewBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFUpdateCollectionViewBehavior.h"

#import "BMFTypes.h"

@implementation BMFUpdateCollectionViewBehavior


- (instancetype) initWithView:(UICollectionView *) collectionView {
	BMFAssertReturnNil(collectionView);
	
    self = [super init];
    if (self) {
        self.collectionView = collectionView;
    }
    return self;
}

- (instancetype)init {
	[NSException raise:@"collectionView is required" format:@"use initWithView: instead"];
	return nil;
}

- (void) viewWillAppear:(BOOL)animated {
	[self.collectionView.collectionViewLayout invalidateLayout];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.collectionView.collectionViewLayout invalidateLayout];
}

@end
