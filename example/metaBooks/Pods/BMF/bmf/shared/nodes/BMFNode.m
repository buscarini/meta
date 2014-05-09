//
//  TNRootNode.m
//  DataSources
//
//  Created by José Manuel Sánchez on 30/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFNode.h"

@implementation BMFNode {
	BOOL _finished;
}

- (id)init {
    self = [super init];
    if (self) {
		_previousNodes = [NSMutableArray array];
		_progress = [NSProgress progressWithTotalUnitCount:1];
        _processBlock = (id)^(id input) {
			return input;
		};
    }
    return self;
}

- (void) setNextNodes:(NSMutableArray *)nextNodes {
	_nextNodes = nextNodes;
	
	for (id<BMFNodeProtocol> nextNode in self.nextNodes) {
		[nextNode.previousNodes addObject:self];
	}
	
	[self computeTotalProgress];
}

- (BOOL) startProcessing {
	[self computeTotalProgress];
	
	_progress.completedUnitCount = 0;
	_finished = NO;
	
	return [self notifyStartProcessing];
}

- (BOOL) notifyStartProcessing {
	BOOL result = YES;
	
	for (id<BMFNodeProtocol> nextNode in self.nextNodes) {
		result &= [nextNode startProcessing];
	}
	
	return result;
}


- (BOOL) process:(id) input completion:(BMFCompletionBlock)block {
	
	[self performProcess:input completion:^(id output, NSError *error) {
		
		_finished = YES;
		
		if (block) block(output,error);
					
		[self checkProgress];
	}];
	
	return YES;
}

- (BOOL) endProcessing {
	
	[self checkProgress];
	
	return YES;
}

- (void) computeTotalProgress {
	_progress.totalUnitCount = 1;
	for (id<BMFNodeProtocol> node in self.previousNodes) {
		_progress.totalUnitCount += node.progress.totalUnitCount;
	}
	
	NSLog(@"object: %@ total unit count: %lld",self,_progress.totalUnitCount);
	
//	if (_progress.totalUnitCount==0) _progress.totalUnitCount = 1;
}

- (void) checkProgress {
	
	if (self.previousNodes.count==0) {
		_progress.completedUnitCount = _progress.totalUnitCount;
		[self checkFinished];
		return;
	}
	
	CGFloat progress = 0;
	for (id<BMFNodeProtocol> node in self.previousNodes) {
		progress += node.progress.completedUnitCount;
	}
	
	_progress.completedUnitCount = progress;
	if (_finished) _progress.completedUnitCount++;
	
	NSLog(@"object: %@ completed: %lld total: %lld",self,_progress.completedUnitCount,_progress.totalUnitCount);
	
	[self checkFinished];
}

- (void) checkFinished {
	if (_progress.fractionCompleted<1) return;
	for (id<BMFNodeProtocol> nextNode in self.nextNodes) {
		[nextNode endProcessing];
	}
}

+ (BMFNode *) nodeWithBlock: (TNNodeBlock) block {
	BMFNode *node = [[BMFNode alloc] init];
	node.processBlock = block;
	return node;
}

- (BOOL) performProcess:(id) input completion:(BMFNodeProcessCompletionBlock) completionBlock {
	id output = self.processBlock(input);
	completionBlock(output,nil);
	return YES;
}

@end
