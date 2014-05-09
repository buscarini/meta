//
//  TNViewDataSourceProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 24/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFDataReadProtocol.h"

@protocol BMFDataSourceProtocol <NSObject>

@property (nonatomic, strong) id<BMFDataReadProtocol> dataStore;

@property (nonatomic, copy) BMFCompletionBlock dataChangedBlock;

@end
