//
//  TNDataStoreProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@protocol BMFDataStoreProtocol <NSObject>

@property (nonatomic, copy) BMFCompletionBlock dataChangedBlock;

- (void) startAdding;
- (BOOL) addItem:(id) item;
- (void) endAdding;

- (void) removeItem:(id) item;
- (void) removeAllItems;

@end
