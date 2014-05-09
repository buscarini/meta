//
//  BMFCollectionViewController.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 06/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMFViewController.h"
#import "BMFViewControllerDataSourceProtocol.h"
#import "BMFArrayProxy.h"

@class BMFCollectionViewDataSource;

@interface BMFCollectionViewController : BMFViewController <BMFViewControllerDataSourceProtocol>

@property (nonatomic, strong) BMFCollectionViewDataSource<BMFDataReadProtocol> *dataSource;

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

//@property (nonatomic, strong) BMFArrayProxy *collectionDelegateProxy;

@end
