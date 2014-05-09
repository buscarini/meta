//
//  TRNTableViewCell.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/12/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMFCellProtocol.h"

@interface BMFTableViewCell : UITableViewCell <BMFCellProtocol>

@property (nonatomic, assign) UIViewContentMode imageViewContentMode;
@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGPoint margin;

@property (nonatomic, weak) id detailItem;

- (void) performInit;
- (void) reset;

@end
