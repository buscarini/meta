//
//  BMFUpdateCollectionViewBehavior.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewControllerBehavior.h"

@interface BMFUpdateCollectionViewBehavior : BMFViewControllerBehavior

@property (nonatomic, weak) UICollectionView *collectionView;

- (instancetype) initWithView:(UICollectionView *) collectionView;


@end
