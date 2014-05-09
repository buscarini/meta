//
//  TNArrayDataStore.h
//  DataSources
//
//  Created by José Manuel Sánchez on 22/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFNode.h"
#import "BMFDataStoreProtocol.h"
#import "BMFDataReadProtocol.h"

@interface BMFArrayDataStore : BMFNode <BMFDataStoreProtocol, BMFDataReadProtocol>

@property (nonatomic, copy) BMFCompletionBlock dataChangedBlock;

@property (nonatomic, copy) NSString *sectionHeaderTitle;
@property (nonatomic, copy) NSString *sectionFooterTitle;

@property (nonatomic, strong) NSArray *items;

- (NSArray *) allItems;

@end
