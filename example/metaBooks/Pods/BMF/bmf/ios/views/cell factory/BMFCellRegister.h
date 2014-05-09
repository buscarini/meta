//
//  TNCellRegister.h
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFCellRegisterProtocol.h"

@interface BMFCellRegister : NSObject <BMFCellRegisterProtocol>

- (void) registerTableCells: (UITableView *) tableView;
- (void) registerCollectionCells:(UICollectionView *) collectionView;
	
@end
