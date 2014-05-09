//
//  BMFItemTapBehavior.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 20/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewControllerBehavior.h"

/// Abstract behavior for subclassing. Responds to table selections, collection view selections
@interface BMFItemTapBehavior : BMFViewControllerBehavior <UITableViewDelegate, UICollectionViewDelegate>

/// YES by default
@property (nonatomic, assign) BOOL deselectItemOnTap;

/// Template method. Should be implemented by subclasses
- (void) itemTapped:(id) item;

@end
