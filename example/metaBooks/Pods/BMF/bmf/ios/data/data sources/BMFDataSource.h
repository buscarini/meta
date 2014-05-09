//
//  BMFDataSource.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 04/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFDataSourceProtocol.h"
#import "BMFDataReadProtocol.h"

@interface BMFDataSource : NSObject <BMFDataSourceProtocol,BMFDataReadProtocol>

/// This can be used as the delegate of the actions of a cell, for example
@property (nonatomic, weak) id controller;

@property (nonatomic, strong) id<BMFDataReadProtocol> dataStore;
@property (nonatomic, copy) BMFCompletionBlock dataChangedBlock;

- (instancetype) initWithDataStore:(id<BMFDataReadProtocol>) dataStore;

@end
