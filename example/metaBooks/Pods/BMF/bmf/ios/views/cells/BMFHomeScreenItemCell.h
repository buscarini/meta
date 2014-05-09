//
//  BMFHomeScreenItemCell.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 06/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFCollectionViewCell.h"

#import "BMFHomeScreenItem.h"

@interface BMFHomeScreenItemCell : BMFCollectionViewCell

@property (nonatomic, strong) BMFHomeScreenItem *item;
@property (nonatomic, copy) BMFActionBlock tapBlock;

@end
