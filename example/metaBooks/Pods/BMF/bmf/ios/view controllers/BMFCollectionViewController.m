//
//  BMFCollectionViewController.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 06/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFCollectionViewController.h"

#import "BMFCollectionViewDataSource.h"

#import "UICollectionView+BMF.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BMFCollectionViewController ()

@end

@implementation BMFCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	__weak BMFCollectionViewController *wself = self;
	
	[[RACObserve(self, dataSource) scanWithStart:nil reduce:^id(id running, id next) {
		[wself removeBehavior:running];
		return next;
	}] subscribeNext:^(id x) {
		wself.collectionView.dataSource = x;
		if (x) [wself addBehavior:x];
		wself.dataSource.collectionView = wself.collectionView;
	}];
	
	[self.BMF_proxy.destinationsSignal subscribeNext:^(id x) {
		[wself.collectionView BMF_updateDelegate:self.BMF_proxy];
	}];
	
	if (self.didLoadBlock) self.didLoadBlock(nil);
}

@end
