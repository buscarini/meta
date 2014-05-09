//
//  TRNCollectionViewCell.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 17/12/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMFCellProtocol.h"

@interface BMFCollectionViewCell : UICollectionViewCell <BMFCellProtocol>

@property (nonatomic, weak) id detailItem;

- (void) performInit;

@end
