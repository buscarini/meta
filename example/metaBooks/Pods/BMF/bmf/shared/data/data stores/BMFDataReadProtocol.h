//
//  TNDataReadProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 05/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@protocol BMFDataReadProtocol <NSObject>

- (NSInteger) numberOfSections;
- (NSInteger) numberOfRowsInSection:(NSUInteger) section;
- (NSString *) titleForSection:(NSUInteger) section kind:(BMFViewKind)kind;
- (id) itemAt:(NSInteger) section row:(NSInteger) row;
- (id) itemAt:(NSIndexPath *) indexPath;

- (NSIndexPath *) indexOfItem:(id) item;

- (NSArray *) allItems;

- (BOOL) isEmpty;

@end
