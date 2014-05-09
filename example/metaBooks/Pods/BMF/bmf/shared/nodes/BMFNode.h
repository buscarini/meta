//
//  TNRootNode.h
//  DataSources
//
//  Created by José Manuel Sánchez on 30/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFNodeProtocol.h"

typedef id(^TNNodeBlock)(id input);

@interface BMFNode : NSObject <BMFNodeProtocol>

@property (nonatomic, strong) NSMutableArray *nextNodes;
@property (nonatomic, strong) NSMutableArray *previousNodes;

@property (nonatomic, weak) id<BMFGraphProtocol> graph;

@property (nonatomic, strong) NSProgress *progress;

@property (nonatomic, strong) TNNodeBlock processBlock;

+ (__autoreleasing BMFNode *) nodeWithBlock: (TNNodeBlock) block;


- (void) checkProgress;

/// Template method for subclasses
- (BOOL) performProcess:(id) input completion:(BMFNodeProcessCompletionBlock) completionBlock;
- (BOOL) notifyStartProcessing;

@end
