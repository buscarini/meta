//
//  UITableView+BMF.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 29/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BMF)

- (void) BMF_hideSeparatorsForEmptyCells;

/// Useful if your delegate is a proxy and its respondToSelector results can vary
- (void) BMF_updateDelegate:(id)delegate;

@end
