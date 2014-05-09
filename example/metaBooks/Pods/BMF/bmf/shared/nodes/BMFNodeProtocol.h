//
//  TNNodeProtocol.h
//  DataSources
//
//  Created by José Manuel Sánchez on 30/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFTypes.h"

@protocol BMFNodeProtocol;
@protocol BMFNodeIteratorProtocol;

@protocol BMFGraphProtocol <NSObject>

@property (nonatomic, strong) id<BMFNodeIteratorProtocol> iterator;

- (BOOL) run: (id) input completion:(BMFCompletionBlock) completionBlock;

- (instancetype) initWithRoot:(id<BMFNodeProtocol>)rootNode;

@end


typedef void(^BMFNodeProcessCompletionBlock)(id output, NSError *error);

@protocol BMFNodeProtocol <NSObject>

@property (nonatomic, strong) NSMutableArray *nextNodes;
@property (nonatomic, strong) NSMutableArray *previousNodes;

@property (nonatomic, weak) id<BMFGraphProtocol> graph;

@property (nonatomic, strong) NSProgress *progress;

- (BOOL) startProcessing;
- (BOOL) process:(id) input completion:(BMFCompletionBlock)block;
- (BOOL) endProcessing;

@end
