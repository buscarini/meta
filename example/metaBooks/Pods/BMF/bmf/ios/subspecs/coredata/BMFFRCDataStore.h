//
//  TNFRDataStore.h
//  DataSources
//
//  Created by José Manuel Sánchez on 05/11/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "BMFNode.h"
#import "BMFDataReadProtocol.h"

@interface BMFFRCDataStore : BMFNode <BMFDataReadProtocol,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fr;

@property (nonatomic, readonly) BOOL loaded;

- (instancetype)initWithController:(NSFetchedResultsController *)fr;

- (BOOL) loadData:(BMFCompletionBlock) completionBlock;

@end
