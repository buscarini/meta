//
//  BMFViewRegister.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 07/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFViewRegisterProtocol.h"

@interface BMFViewRegister : NSObject <BMFViewRegisterProtocol>

- (void) registerTableViews: (UITableView *) tableView;
- (void) registerCollectionViews:(UICollectionView *) collectionView;

@end
