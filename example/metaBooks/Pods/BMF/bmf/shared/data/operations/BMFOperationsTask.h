//
//  BMFTask.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTaskProtocol.h"

#import "BMFOperation.h"

#import "BMFActionableProtocol.h"

/*
 
 BMFOperationsTask is a task that contains an operation queue, and is composed by operations
 
 */

@interface BMFOperationsTask : NSObject <BMFTaskProtocol, BMFActionableProtocol>

@property (nonatomic, strong) BMFProgress *progress;

@property (nonatomic, assign) BOOL manualDependencies; // NO by default
@property (nonatomic, assign) BOOL usePrivateQueue; // NO by default. This means that we use the BMFBase backgroundQueue

@property (nonatomic, weak) NSOperationQueue *queue;

- (void) addOperation:(BMFOperation *) operation;

- (instancetype) initWithOperations:(NSArray *) operations;

#pragma mark Actionable

- (void) action:(id)input completion:(BMFCompletionBlock)completion;

@end
